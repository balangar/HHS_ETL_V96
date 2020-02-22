#region Help:  Introduction to the script task
/* The Script Task allows you to perform virtually any operation that can be accomplished in
 * a .Net application within the context of an Integration Services control flow. 
 * 
 * Expand the other regions which have "Help" prefixes for examples of specific ways to use
 * Integration Services features within this script task. */
#endregion

#region Namespaces
using System;
using System.Data;
using Microsoft.SqlServer.Dts.Runtime;
using System.Windows.Forms;
using System.IO;
using System.Threading;
#endregion
namespace SqlServerCentral
{
    /// <summary>
    /// ScriptMain is the entry point class of the script.  Do not change the name, attributes,
    /// or parent of this class.
    /// </summary>
    [Microsoft.SqlServer.Dts.Tasks.ScriptTask.SSISScriptTaskEntryPointAttribute]
    public partial class ScriptMain : Microsoft.SqlServer.Dts.Tasks.ScriptTask.VSTARTScriptObjectModelBase
    {
        #region Help:  Using Integration Services variables and parameters in a script
        /* To use a variable in this script, first ensure that the variable has been added to 
         * either the list contained in the ReadOnlyVariables property or the list contained in 
         * the ReadWriteVariables property of this script task, according to whether or not your
         * code needs to write to the variable.  To add the variable, save this script, close this instance of
         * Visual Studio, and update the ReadOnlyVariables and 
         * ReadWriteVariables properties in the Script Transformation Editor window.
         * To use a parameter in this script, follow the same steps. Parameters are always read-only.
         * 
         * Example of reading from a variable:
         *  DateTime startTime = (DateTime) Dts.Variables["System::StartTime"].Value;
         * 
         * Example of writing to a variable:
         *  Dts.Variables["User::myStringVariable"].Value = "new value";
         * 
         * Example of reading from a package parameter:
         *  int batchId = (int) Dts.Variables["$Package::batchId"].Value;
         *  
         * Example of reading from a project parameter:
         *  int batchId = (int) Dts.Variables["$Project::batchId"].Value;
         * 
         * Example of reading from a sensitive project parameter:
         *  int batchId = (int) Dts.Variables["$Project::batchId"].GetSensitiveValue();
         * */
        #endregion
        #region Help:  Firing Integration Services events from a script
        /* This script task can fire events for logging purposes.
         * 
         * Example of firing an error event:
         *  Dts.Events.FireError(18, "Process Values", "Bad value", "", 0);
         * 
         * Example of firing an information event:
         *  Dts.Events.FireInformation(3, "Process Values", "Processing has started", "", 0, ref fireAgain)
         * 
         * Example of firing a warning event:
         *  Dts.Events.FireWarning(14, "Process Values", "No values received for input", "", 0);
         * */
        #endregion
        #region Help:  Using Integration Services connection managers in a script
        /* Some types of connection managers can be used in this script task.  See the topic 
         * "Working with Connection Managers Programatically" for details.
         * 
         * Example of using an ADO.Net connection manager:
         *  object rawConnection = Dts.Connections["Sales DB"].AcquireConnection(Dts.Transaction);
         *  SqlConnection myADONETConnection = (SqlConnection)rawConnection;
         *  //Use the connection in some code here, then release the connection
         *  Dts.Connections["Sales DB"].ReleaseConnection(rawConnection);
         *
         * Example of using a File connection manager
         *  object rawConnection = Dts.Connections["Prices.zip"].AcquireConnection(Dts.Transaction);
         *  string filePath = (string)rawConnection;
         *  //Use the connection in some code here, then release the connection
         *  Dts.Connections["Prices.zip"].ReleaseConnection(rawConnection);
         * */
        #endregion
        #region Instance variables
        // we need access to the found file info from the FileSystemWatcher OnFileCreate event in our class 
        // scope. an instance variable may look odd but will do for our purposes
        private FileInfo foundFile = null;
        #endregion
        #region Method: void Main()
        /// <summary>
        /// This method is called when this script task executes in the control flow.
        /// Before returning from this method, set the value of Dts.TaskResult to indicate success or failure.
        /// To open Help, press F1.
        /// </summary>
        public void Main()
        {
            try
            {
                // initialize common variables from DTS variables collection
                string dropDirectory = Dts.Variables["User::WatcherInputDropPath"].Value.ToString();
                string fileMask = Dts.Variables["User::WatcherInputFileMask"].Value.ToString();
                bool includeSubdirectories = Convert.ToBoolean(Dts.Variables["User::WatcherInputIncludeSubdirectories"].Value);
                // look for existing files if configuration suggests we should
                bool findExistingFiles = Convert.ToBoolean(Dts.Variables["User::WatcherInputFindExistingFiles"].Value);
                if (findExistingFiles)
                {
                    FindExistingFile(dropDirectory, fileMask, includeSubdirectories);
                }
                // do we (still) need to look for a file?
                if (foundFile == null)
                {
                    // if we made it here there were no existing files to process (or we didn't check for them per the 
                    // configuration variables) so setup a FileSystemWatcher object per the configuration variables
                    bool timeoutAsWarning = Convert.ToBoolean(Dts.Variables["User::WatcherInputTimeoutAsWarning"].Value);
                    int timeoutSeconds = Convert.ToInt32(Dts.Variables["User::WatcherInputTimeoutSeconds"].Value);
                    int timeoutMilliseconds = (timeoutSeconds == 0 ? -1 : timeoutSeconds * 1000);
                    WatchForFileCreation(dropDirectory, fileMask, includeSubdirectories, timeoutAsWarning, timeoutMilliseconds);
                }
                Dts.TaskResult = (int)ScriptResults.Success;
            }
            catch (Exception e)
            {
                Dts.Events.FireError(0, null, e.Message, string.Empty, 0);
                Dts.TaskResult = (int)ScriptResults.Failure;
            }
        }
        #endregion
        #region Event: void OnFileCreate(object source, FileSystemEventArgs e)
        /// <summary>
        /// Event attached to FileSystemWatcher when a file is created.
        /// </summary>
        /// <param name="source">Event source.</param>
        /// <param name="e">Event arguments.</param>
        private void OnFileCreate(object source, FileSystemEventArgs e)
        {
            PreProcessFoundFile(new FileInfo(e.FullPath));
        }
        #endregion
        #region Method: WatchForFileCreation
        /// <summary>
        /// Sets up a FileSystemWatcher to watch for new files being created.
        /// </summary>
        /// <param name="dropDirectory">Directory to watch</param>
        /// <param name="fileMask">File pattern mask of files being watched for.</param>
        /// <param name="includeSubdirectories">If true all subdirectories are also watched.</param>
        /// <param name="timeoutAsWarning">If true then if watcher times out only a warning is raised, i.e. the Task succeeds.</param>
        /// <param name="timeoutMilliseconds">Number of milliseconds to wait for a file to be initially created. This timeout period 
        /// does not apply to the tiem spent waiting for exclusive access to be gained to the file.</param>
        private void WatchForFileCreation(string dropDirectory,
            string fileMask,
            bool includeSubdirectories,
            bool timeoutAsWarning,
            int timeoutMilliseconds)
        {
            // create a new FileSystemWatcher
            FileSystemWatcher fileSystemWatcher = new FileSystemWatcher();
            // set the path to watch to our 'drop directory'
            fileSystemWatcher.Path = dropDirectory;
            // set the option to watch subdirectories
            fileSystemWatcher.IncludeSubdirectories = includeSubdirectories;
            // set the filter of files to watch for to our 'file mask'
            fileSystemWatcher.Filter = fileMask;
            // add event handler to execute when new files are created
            fileSystemWatcher.Created += new FileSystemEventHandler(OnFileCreate);
            // begin watching
            fileSystemWatcher.WaitForChanged(WatcherChangeTypes.Created, timeoutMilliseconds);
            if (foundFile == null)
            {
                // the file watcher timed out waiting for a file  :-<
                string message = "Timeout waiting for file {Path='" + dropDirectory + "'; Filter='" + fileMask + 
                     "'; IncludeSubdirectories=" + includeSubdirectories.ToString() + "}.";
                if (timeoutAsWarning)
                {
                    // only raise a warning
                    Dts.Events.FireWarning(0, null, message, string.Empty, 0);
                }
                else
                {
                    // raise an error
                    throw new TimeoutException(message);
                }
            }
        }
        #endregion
        #region Method: void PreProcessFoundFile(FileInfo dataFile)
        /// <summary>
        /// Takes actions subsequent to locating a file that allow later processing of the file. This method
        /// reports information to the parent container by firing info events. This method also ensures exclusive 
        /// access to the file can be achieved before returning control to the parent container.
        /// </summary>
        /// <param name="dataFile">File to preprocess.</param>
        private void PreProcessFoundFile(FileInfo dataFile)
        {
            // set the instance variable value to the found file
            this.foundFile = dataFile;
            // local variable to pass to events that require parameters be passed by ref
            bool fireAgain = true;
            // raise an information event saying we found a file (not necessarily that it can be used)
            Dts.Events.FireInformation(0, null, "File found: " + dataFile.FullName, string.Empty, 0, ref fireAgain);
            // We know there is a new file that can be processed because
            // the FileSystemWatcher fired an event, however we do not know if the user or process
            // supplying the file has completed uploading it. We will loop over drop directory
            // looking for files that meet our criteria and once we find one we will make sure
            // the supplier has completed their upload process by checking to see if we can gain 
            // exclusive access to the file. Once we can gain exclusive access to the file we will know
            // the upload is complete and we can allow the rest of the SSIS package to continue.
            WaitForExclusiveAccess(dataFile);
            // store the full file name (includes path) in output variable
            Dts.Variables["User::WatcherOutputFileFullName"].Value = dataFile.FullName;
            // store the file name in output variable
            Dts.Variables["User::WatcherOutputFileName"].Value = dataFile.Name;
            // raise an information event saying we found a file -and- it can be used
            Dts.Events.FireInformation(0, null, "File ready for use: " + dataFile.FullName, string.Empty, 0, ref fireAgain);
        }
        #endregion
        #region Method: void WaitForExclusiveAccess(FileInfo dataFile)
        /// <summary>
        /// Waits until exclusive access to a file can be achieved.
        /// </summary>
        /// <param name="dataFile">File to access.</param>
        private void WaitForExclusiveAccess(FileInfo dataFile)
        {
            // local variable to say how many seconds to wait in between checking if we can gain 
            // exclusive access to the found file
            int secondsToWaitBetweenAttempts = 5;
            // local variable to pass to events that require parameters be passed by ref
            bool fireAgain = true;
            // Loop indefinitely checking if we can access the data file.
            while (1 == 1)
            {
                try
                {
                    // Attempt to gain access to the file.
                    using (Stream stream = new FileStream(dataFile.FullName, FileMode.Open))
                    {
                        // If we made it here no exception was thrown meaning we 
                        // could access the file. We will break out of the loop and allow 
                        // the rest of the package to continue processing.
                        break;
                    }
                }
                catch (IOException)
                {
                    // We are not interested in ending the program when an IOException
                    // occurs in this area. This type of exception means we could not 
                    // gain access to the file.
                    // In general, programming algorithms that leverage exceptions for 
                    // control flow are frowned upon. However in the case of file access 
                    // it is an acceptable pattern.
                }
                // raise an information event saying we could not gain exclusive access to the found file and will wait
                Dts.Events.FireInformation(0, null, "Could not gain exclusive access to file " + foundFile.FullName + 
                                                           ". Waiting " + secondsToWaitBetweenAttempts.ToString() + 
                                                           " seconds before trying again...", string.Empty, 0, ref fireAgain);
                // wait some time before checking whether the file can be used
                Thread.Sleep(secondsToWaitBetweenAttempts * 1000);
            }
        }
        #endregion
        #region Method: void FindExistingFile(string directoryName, string fileMask, bool includeSubdirectories)
        /// <summary>
        /// Check a directory for files that match a file mask.
        /// </summary>
        /// <param name="directoryName">Directory to look for files.</param>
        /// <param name="fileMask">File pattern mask matching files to look for.</param>
        /// <param name="includeSubdirectories">True if subdirectories should also be checked.</param>
        private void FindExistingFile(string directoryName, string fileMask, bool includeSubdirectories)
        {
            // local variable to pass to events that require parameters be passed by ref
            bool fireAgain = true;
            // get the list of files that qualify
            DirectoryInfo directoryInfo = new DirectoryInfo(directoryName);
            FileInfo[] fileInfos;
            if (includeSubdirectories)
            { fileInfos = directoryInfo.GetFiles(fileMask, SearchOption.AllDirectories); }
            else
            { fileInfos = directoryInfo.GetFiles(fileMask, SearchOption.TopDirectoryOnly); }
            // check to see if any files were found
            if (fileInfos.Length > 0)
            {
                // found a file!
                PreProcessFoundFile(fileInfos[0]);
                // raise an info message
                Dts.Events.FireInformation(0, null, "Existing files found: " + fileInfos.Length.ToString(), string.Empty, 0, ref fireAgain);
            }
            else
            {
                // no files found, raise a warning
                Dts.Events.FireWarning(0, null, "No existing files found.", string.Empty, 0);
            }
        }
        #endregion
        #region ScriptResults declaration
        /// <summary>
        /// This enum provides a convenient shorthand within the scope of this class for setting the
        /// result of the script.
        /// 
        /// This code was generated automatically.
        /// </summary>
        enum ScriptResults
        {
            Success = Microsoft.SqlServer.Dts.Runtime.DTSExecResult.Success,
            Failure = Microsoft.SqlServer.Dts.Runtime.DTSExecResult.Failure
        };
        #endregion
    }
}
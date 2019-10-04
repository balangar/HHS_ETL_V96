using System;
using System.Collections.Generic;

namespace Prepare_FinancialNotes
{
    internal abstract class BaseLogEntry
    {
        private static Dictionary<string, Func<string, BaseLogEntry>> Factories;        
        internal string RecordType { get; }
        internal string RecordSubtype { get; }
        internal abstract XmlOutput GetXML(XmlOutput XO);

        internal static BaseLogEntry CreateEntry(LogRecord Record)
        {
            string key = Record.RecordType + Record.RecordSubtype;
            if (Factories.ContainsKey(key))
            {
                return Factories[key](Record.Text);
            }
            throw new IndexOutOfRangeException(string.Format(@"Unrecognized record type or subtype : {0}  {1}", Record.RecordType, Record.RecordSubtype));
        }

        static BaseLogEntry()
        {
            // Register all of the record types
            Factories = new Dictionary<string, Func<string, BaseLogEntry>>
            {
                { "FinRecord", s => new LogHeader(s) },
                { "RECEIPTMaster", s => new ReceiptLogEntry(s) }
            };
        }
        internal BaseLogEntry(string RecordText)
        {
            // consts that do offset
        }
    }
    internal class LogHeader : BaseLogEntry
    {
        /* Serves as the "root" of the subsequent XML "tree" for given LogBlock records
         * There is no log record that corresponds to this .. so I'm free to pass in
         * a string that renders the result I want.
         * 
         * Done this way for the sack of consistency
         */

        const int ORDER_NUMBER_OFFSET = 0; const int ORDER_NUMBER_LENGTH = 16;
        const int BLOCK_DATE_OFFSET = 17; const int BLOCK_DATE_LENGTH = 10;
        const int RECORD_TYPE_OFFSET = 27; const int RECORD_TYPE_LENGTH = 8; //"FinRecord".Length;
        string OrderNo { get; }
        string BlockDate { get; }
        internal override XmlOutput GetXML(XmlOutput XO)
        {
            return (
                XO
                .XmlDeclaration()
                .Node(RecordType).Within()
                .Attribute("OrderNumber", OrderNo)
                .Attribute("Date", BlockDate)
                );

        }
        internal LogHeader(string LogHeaderText) : base(LogHeaderText)
        {
            OrderNo = LogHeaderText.Substring(ORDER_NUMBER_OFFSET, ORDER_NUMBER_LENGTH);
            BlockDate = LogHeaderText.Substring(BLOCK_DATE_OFFSET, BLOCK_DATE_LENGTH);
        }
    }
    internal class ReceiptLogEntry : BaseLogEntry
    {
        const int PAYEE_TYPE_OFFSET = 47; const int PAYEE_TYPE_LENGTH = 3;
        const int AMOUNT_RECEIVED_OFFSET = 61; const int AMOUNT_RECEIVED_LENGTH = 8;
        const int ALTERNATE_PAYEE_OFFSET = 50; const int ALTERNATE_PAYEE_LENGTH = 10;
        
        string PayeeType { get; }
        string AmountReceived { get; }
        string AlternatePayee { get; }
        internal override XmlOutput GetXML(XmlOutput XO)
        {
            return (
                XO
                .Node(RecordType)
                .Attribute("AmountRecived", AmountReceived)
                .Attribute("AlternatePayee", AlternatePayee)
                );
        }
        internal ReceiptLogEntry(string RecordText) : base(RecordText)
        {
            PayeeType = RecordText.Substring(PAYEE_TYPE_OFFSET, PAYEE_TYPE_LENGTH);
            AmountReceived = RecordText.Substring(AMOUNT_RECEIVED_OFFSET, AMOUNT_RECEIVED_LENGTH);
            AlternatePayee = RecordText.Substring(ALTERNATE_PAYEE_OFFSET, ALTERNATE_PAYEE_LENGTH);
        }

    }
}
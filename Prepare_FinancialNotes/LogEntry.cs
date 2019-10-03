using System;

namespace Prepare_FinancialNotes
{
    internal abstract class BaseLogEntry
    {
        internal XmlOutput xo;
        internal abstract XmlOutput GetXML();
    }
    internal class BlockHeader : BaseLogEntry
    {
        string OrderNo { get; }
        string BlockDate { get; }
        internal override XmlOutput GetXML()
        {
            return( new XmlOutput()
                .XmlDeclaration()
                .Node("FinRecord").Within()
                .Attribute("OrderNumber", OrderNo)
                .Attribute("Date", BlockDate));

        }
        internal BlockHeader(string OrderNumber, string BlockDate)
        {
            OrderNo = OrderNumber;
            this.BlockDate = BlockDate;
        }
    }
    internal class ReceiptLogEntry : BaseLogEntry
    {
        const int AMOUNT_RECEIVED_OFFSET = 18; const int AMOUNT_RECEIVED_LENGTH = 8;

        string AmountReceived { get; }
        internal override XmlOutput GetXML()
        {
            throw new NotImplementedException();
        }
        internal ReceiptLogEntry(string RecordText) : base()
        {
            AmountReceived = RecordText.Substring(AMOUNT_RECEIVED_OFFSET, AMOUNT_RECEIVED_LENGTH);
        }

    }
}
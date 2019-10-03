using System;

namespace Prepare_FinancialNotes
{
    internal abstract class BaseLogEntry
    {
        internal abstract XmlOutput GetXML(XmlOutput XO);
    }
    internal class BlockHeader : BaseLogEntry
    {
        string OrderNo { get; }
        string BlockDate { get; }
        internal override XmlOutput GetXML(XmlOutput XO)
        {
            return (
                XO
                .XmlDeclaration()
                .Node("FinRecord").Within()
                .Attribute("OrderNumber", OrderNo)
                .Attribute("Date", BlockDate)
                );

        }
        internal BlockHeader(string OrderNumber, string BlockDate)
        {
            OrderNo = OrderNumber;
            this.BlockDate = BlockDate;
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
                .Node("RECEIPT")
                .Attribute("AmountRecived", AmountReceived)
                .Attribute("AlternatePayee", AlternatePayee)
                );
        }
        internal ReceiptLogEntry(string RecordText) : base()
        {
            PayeeType = RecordText.Substring(PAYEE_TYPE_OFFSET, PAYEE_TYPE_LENGTH);
            AmountReceived = RecordText.Substring(AMOUNT_RECEIVED_OFFSET, AMOUNT_RECEIVED_LENGTH);
            AlternatePayee = RecordText.Substring(ALTERNATE_PAYEE_OFFSET, ALTERNATE_PAYEE_LENGTH);
        }

    }
}
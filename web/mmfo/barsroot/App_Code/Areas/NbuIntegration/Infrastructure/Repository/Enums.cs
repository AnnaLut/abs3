namespace BarsWeb.Areas.NbuIntegration
{
    public enum RequestState
    {
        RequestReceived = 1,
        SignChecked = 2,
        DocumentsCreated = 3,
        Paid = 4,
        RequestError = 11,
        SignCheckError = 12,
        CreateDocumentsError = 13,
        PaymentError = 14
    }
    public enum DocumentState
    {
        New = 1,
        Checked = 2,
        Paid = 3,
        NotValidData = 12,
        PaymentError = 13
    }

    public enum SagoParams
    {
        URL,
        MethodUrl,
        UserName,
        Password,
        Domain
    }
}
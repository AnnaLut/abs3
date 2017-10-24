namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    public class SyncInvokerStartInfo
    {
        public ISynchronizerFactory SynchronizerFactory { get; set; }

        public string TransferType { get; set; }
    }
}
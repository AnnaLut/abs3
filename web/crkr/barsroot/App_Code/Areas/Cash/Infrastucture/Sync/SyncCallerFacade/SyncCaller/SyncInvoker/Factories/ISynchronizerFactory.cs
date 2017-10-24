namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Фабрика создания синхронизаторов
    /// </summary>
    public interface ISynchronizerFactory
    {
        SynchronizerBase GetSynchronizer();
    }
}
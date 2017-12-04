using System;

namespace BarsWeb.Areas.PfuSync.Infrastructure.Repository.DI.Abstract
{
    public interface IPfuSyncGZipRepository
    {
        string Decompress(string compressedText);
        string Compress(string text);
    }
}
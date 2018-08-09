using System.Collections.Generic;
using BarsWeb.Areas.GL.Models;

namespace BarsWeb.Areas.GL.Infrastructure.Repository.DI.Abstract
{
    public interface INLRepository
    {
        IEnumerable<File> FilesData(string tip);
        IEnumerable<SubFile> SubFileData(decimal acc);
        void RemoveDocument(decimal id);
        IEnumerable<Operation> OperDictionary(string type);
        SwiftInfo GetSwiftInfo(decimal refid);
    }

}
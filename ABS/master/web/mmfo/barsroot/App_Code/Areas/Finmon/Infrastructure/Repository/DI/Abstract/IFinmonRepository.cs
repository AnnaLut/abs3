using System.Linq;
using Areas.Finmon.Models;

namespace BarsWeb.Areas.Finmon.Infrastructure.Repository.DI.Abstract
{
    public interface IFinmonRepository
    {
        IQueryable<V_OPER_FM> GetOperFm();

        /// <summary>
        /// Загрузка ФМ-файла - списка террористов / публичных деятелей
        /// </summary>
        /// <param name="fileType">Тип файла для загрузки: (Terr, PEP, KIS) -> (террористы, публичные от pep.org.ua, публичные от ТОВ "КИС")</param>
        /// <param name="data">Содержимое файла</param>
        /// <returns>"Завантажено %n записів"</returns>
        string ImportFile(string fileType, string data);
    }
}
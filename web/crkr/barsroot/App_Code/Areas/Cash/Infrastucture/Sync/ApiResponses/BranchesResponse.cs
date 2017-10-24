using System.Collections.Generic;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Ответ от метода получения перечня отделений (бранчей)
    /// </summary>
    public class BranchesResponse
    {
        /// <summary>
        /// Успешность выполнения метода
        /// </summary>
        public bool Success { get; set; }

        /// <summary>
        /// Сообщение об ошибке
        /// </summary>
        public string ErrorMessage { get; set; }

        /// <summary>
        /// Перечень отделений (бранчей)
        /// </summary>
        public IEnumerable<RegionBranch> Branches { get; set; }
    }
}
namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// ѕараметры сортировки данных в гриде справочника
    /// </summary>
    public class SortParam
    {
        public string Property { get; set; }
        public string Direction { get; set; }
        public string Order
        {
            get { return Property + " " + Direction; }
        }
    }
}
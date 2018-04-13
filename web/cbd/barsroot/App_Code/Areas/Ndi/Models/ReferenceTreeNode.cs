namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Описание узла-листа дерева справочников (в нужном для Extjs формате)
    /// </summary>
    public class ReferenceTreeNode
    {
        public string name { get; set; }
        public bool leaf { get; set; }
        public string href { get; set; }
        public string iconCls { get; set; }
    }
}
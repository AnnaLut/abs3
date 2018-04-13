using System.Collections.Generic;


namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Описание узла-группы дерева справочников (в нужном для Extjs формате)
    /// </summary>
    public class ReferenceTreeGroupNode
    {
        public string name { get; set; }
        public bool expanded { get; set; }
        public List<ReferenceTreeNode> children { get; set; }

    }
}

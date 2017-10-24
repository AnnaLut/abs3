using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for VSepQdocs_partial
/// </summary>
/// 
namespace qdocs
{ 
	public partial class VSepQdocs
	{
		public List<VSepQdocsRecord> SelectQDocs(String SortExpression, int maximumRows, int startRowIndex)
		{
			return this.Select(SortExpression, maximumRows, startRowIndex);
		}
	}
}
using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ExtValSemanticComparer
/// </summary>
public class ExtValSemanticComparer : IEqualityComparer<ColumnMetaInfo>
{

    public bool Equals(ColumnMetaInfo x, ColumnMetaInfo y)
    {
        return x.SrcColFullName == y.SrcColFullName;
    }

    public int GetHashCode(ColumnMetaInfo item)
    {
        return item.SrcColFullName.GetHashCode();
    }
}
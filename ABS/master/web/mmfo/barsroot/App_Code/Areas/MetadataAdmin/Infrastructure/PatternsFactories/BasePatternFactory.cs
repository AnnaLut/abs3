using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.MetaDataAdmin.Models;
/// <summary>
/// Summary description for BasePatternFactory
/// </summary>
public abstract class BasePatternFactory<T, R> where T : BaseInputFactoryModel where R : BaseOutPutPatternModel
{
    

    public abstract R GetFullGridMdel(T model);

    public virtual List<ColumnMetaInfo> GetMetaColumns { get;private  set; }

    protected T InputModel { get; set; }
    protected  R OutPutModel { get; set; }
}
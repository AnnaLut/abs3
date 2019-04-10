using barsroot.core;
using BarsWeb.Areas.Ndi.Models.DbModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for HiddenColumnsViewModel
/// </summary>
public class HiddenColumnsViewModel
{
    public HiddenColumnsViewModel(MetaTable tableInfo, UserMap user)
    {
        HiddenColumnsKey = HiddenColumnsKeyPrefix + "_" + user.user_id + "_" + tableInfo.TABID;
    }
    
    private const string HiddenColumnsKeyPrefix = "hiddenColumnsKey";
    public string HiddenColumnsKey { get; set; }
    public bool HasSyncHidColsToStorage { get; set; }
    public List<string> HiddenColumns { get; set; }
    //тип синхронизации. По умолчанию по нажатию на кнопку..... Если пустое поле - не запоминаем колонки.
    public string Kind { get; set; }


}
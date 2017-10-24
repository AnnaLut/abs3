﻿using BarsWeb.Areas.DptAdm.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Abstract
{
    public interface IEditFinesDFORepository
    {
        List<T> GetData<T>(string modcode);
        List<T> GetFineData<T>(int fineid);
        List<T> IfCheckBoxs<T>(int id);
        List<T> TypesList<T>(string type);
        void InsertFine(dynamic grid, dynamic ID);
        String InsertRow(dynamic grid);
        String DeleteRow(dynamic rows);
        String DeleteFineSetting(dynamic rows, dynamic ID);
        String UpdateRow(dynamic rows);
        void UpdateFine(dynamic grid, dynamic ID);

    }
}
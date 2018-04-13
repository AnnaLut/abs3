using System;
using System.Collections.Generic;
using System.Linq;
using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{/*
    public class ModulesRepository : IModulesRepository
    {
        Entities _entities;
        public ModulesRepository(IAdminModel model)
        {
		    _entities = model.Entities;
        }

        public IQueryable<APPLIST> GetModule()
        {
            return _entities.APPLISTs.OrderBy(i => i.CODEAPP);
        }

        public APPLIST GetModule(string codeapp)
        {
            return _entities.APPLISTs.FirstOrDefault(i => i.CODEAPP == codeapp);
        }

        public List<V_OPERAPP> GetFunction(string codeapp)
        {
            object[] parameters = 
                    { 
                        new OracleParameter("p_codeapp",OracleDbType.Varchar2).Value=codeapp
                    };
            string sql = "SELECT * FROM v_operapp vo where vo.codeapp = :p_codeapp order by codeoper";
            return _entities.ExecuteStoreQuery<V_OPERAPP>(sql, parameters).ToList();
        }

        public IQueryable<OPERLIST> GetNotInFunction(string codeapp)
        {
            var func = GetFunction(codeapp).Select(it => it.CODEOPER);
            return _entities.OPERLISTs.Where(i => !func.Contains(i.CODEOPER)).OrderBy(i => i.CODEOPER);
        }

        public void UpdateModule(string codeapp)
        { 
            var mod = GetModule(codeapp);
            _entities.FUNC_MGR_ADD_APPLICATION(mod.CODEAPP, mod.NAME, mod.HOTKEY, mod.FRONTEND,String.Empty);
        }
    }*/
}
using Bars.CommonModels.ExternUtilsModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Bars.Oracle.Factories;

/// <summary>
/// Summary description for ExecModelFactory
/// </summary>
namespace Bars.Oracle.Factories
{
    public class ExternModelFactory
    {

        private LoginFactory loginFactory;

        public ExternModelFactory(AvailableExecTypes execType)
        {
            loginFactory = new LoginFactory();
        }
        

        public ExcelExtModel CreateExecModel(SelectModel selectModel)
        {
            ExcelExtModel excelModel = new ExcelExtModel();
            excelModel.SelectModel = selectModel;
            excelModel.LoginModel = loginFactory.CreateLoginModel;
            return excelModel;

        }

    }
}
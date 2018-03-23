using System;
using System.IO;
using System.Web.Mvc;
using BarsWeb.Controllers;
using BarsWeb.Models;
using BarsWeb.Areas.LinkedGroupReference.Infrastructure.Repository.DI.Abstract;
using Oracle.DataAccess.Client;
using System.Reflection;
using System.Net.Mime;

namespace BarsWeb.Areas.LinkedGroupReference.Controllers
{
    public class LGroupsReferenceController : ApplicationController
    {
        private readonly ILinkedGroupReferenceRepository _repo;
        private LinkedGroupHelper helper;

        //Імена файлів логів помилок:
        private const string ProcedureLogFileName = "\\Log of errors after filling LinkedGroups.txt";
        private const string ReferenceBookLogFileName = "\\Log of errors of excel reference book.txt";

        private const string ResultContentType = "text/html";
        private JsonResponse JsonResult; 

        public LGroupsReferenceController(ILinkedGroupReferenceRepository repo)
        {
            _repo = repo;
            JsonResult = new JsonResponse(JsonResponseStatus.Ok);
        }
        /// <summary>
        /// Повертає сторінку вибору довідника
        /// </summary>
        /// <returns></returns>
        public ViewResult Index()
        {
            return View();
        }

        /// <summary>
        /// Перевіряє завантажений файл довідника та записує дані в БД, якщо немає помилок при завантаженні та в форматі файлу
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UploadDocument()
        {
            var file = Request.Files[0];
           
            try
            {
                string dirPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
                string parsingResultFileName = dirPath + ReferenceBookLogFileName;

                FileInfo parsingResultFile = new FileInfo(parsingResultFileName);

                if (this.helper == null)
                    helper = new LinkedGroupHelper(_repo);

                bool parsingFoundErrors = false;

                string checkFileNameResult = helper.CheckFileName(file.FileName);

                if (checkFileNameResult != "")
                {
                    JsonResult.status = JsonResponseStatus.Error;
                    JsonResult.message = checkFileNameResult;
                    throw new Exception(JsonResult.message);
                }
                else
                {
                    //Parse File and insert records to DB
                    parsingFoundErrors = helper.ParseExcelFile(file, parsingResultFile);

                    if (parsingFoundErrors)
                    {
                        TempData["parsingResultFileName"] = parsingResultFileName;
                        return File(parsingResultFile.OpenRead(), "text/plain");
                    }
                    else
                    {
                        parsingResultFile.Delete();
                        return Json(JsonResult, ResultContentType, JsonRequestBehavior.AllowGet);
                    }
                }

            }
            catch (OracleException orex)
            {
                JsonResult.status = JsonResponseStatus.Error;
                JsonResult.message = orex.Message;
                JsonResult.data = orex.Data;
            }
            catch (Exception ex)
            {
                JsonResult.status = JsonResponseStatus.Error;
                JsonResult.message = ex.InnerException == null ? ex.Message : ex.InnerException.Message;
            }

            return Json(JsonResult, ResultContentType, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LaunchProcedure()
        {
            try
            {
                var resLogFileString = _repo.SetLinkGroups();

                //if procedure has executed successfuly:
                if (string.IsNullOrEmpty(resLogFileString))
                {
                    return Json(JsonResult, ResultContentType, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    string dirPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
                    string execProcedureFileName = dirPath + ProcedureLogFileName;

                    TempData["execProcedureFileName"] = execProcedureFileName;

                    //create and write log file from error string from db:
                    FileInfo procLogFile = new FileInfo(execProcedureFileName);
                    using (StreamWriter errorsResFile = procLogFile.CreateText())
                    {
                        string[] fileLines = resLogFileString.Split(new string[] { "\n" }, StringSplitOptions.RemoveEmptyEntries);
                        for (int i = 0; i < fileLines.Length; i++)
                        {
                            errorsResFile.WriteLine(fileLines[i]);
                        }
                    }

                    return File(procLogFile.OpenRead(), ResultContentType);
                }
            }
            catch (Exception ex)
            {
                JsonResult.status = JsonResponseStatus.Error;
                JsonResult.message = ex.Message;
                JsonResult.data = ex.Data;
            }

            return Json(JsonResult, ResultContentType, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SaveLog(string id)
        {
            string fullFileName;
            switch (id)
            {
                case "upload":
                    fullFileName = TempData["parsingResultFileName"].ToString();
                    break;
                case "procedure":
                    fullFileName = TempData["execProcedureFileName"].ToString();
                    break;
                default:
                    fullFileName = "";
                    break;
            }

            return File(fullFileName, MediaTypeNames.Text.Plain, ReferenceBookLogFileName);
        }

    }
}
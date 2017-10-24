using BarsWeb.Areas.DepoFiles.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Areas.DepoFiles.Models;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using System.IO;
using System.Collections;
using System.Text;
using AttributeRouting.Web.Http;
using System.Globalization;

namespace BarsWeb.Areas.DepoFiles.Controllers.Api
{
    public class DepoFilesApiController : ApiController
    {
        private readonly IDepoFilesRepository _repository;

        public DepoFilesApiController(IDepoFilesRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage GetAcceptedFiles([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            try
            {
                var list = _repository.GetAcceptedFiles();
                return Request.CreateResponse(HttpStatusCode.OK, list.ToList().ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetStatistics(decimal header_id)
        {
            try
            {
                string statisctic = _repository.GetStatistics(header_id);
                return Request.CreateResponse(HttpStatusCode.OK, statisctic);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage MarkLine(decimal info_id, decimal mark)
        {
            try
            {
                _repository.MarkLine(info_id, mark);
                return Request.CreateResponse(HttpStatusCode.OK, "Стрічку відмінено.");
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetShowFile([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, decimal? header_id, bool incorrect, bool unknown, bool excluded)
        {
            try
            {
                if (header_id != null)
                {
                    IEnumerable<ShowFile> statisctic = _repository.GetShowFile(header_id);
                    if (unknown)
                        statisctic = statisctic.Where(x => x.INCORRECT == 0 && x.REAL_ACC_NUM == null);
                    if (incorrect)
                        statisctic = statisctic.Where(x => x.INCORRECT > 0);
                    if (excluded)
                        statisctic = statisctic.Where(x => x.EXCLUDED > 0 || x.MARKED4PAYMENT == 0);
                    return Request.CreateResponse(HttpStatusCode.OK, statisctic.ToList().ToDataSourceResult(request));
                }
                else
                    return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage Copy(decimal? header_id)
        {
            try
            {
                decimal new_header_id = _repository.Copy(header_id);
                return Request.CreateResponse(HttpStatusCode.OK, new_header_id);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage Delete(decimal? header_id)
        {
            try
            {
                _repository.Delete(header_id);
                return Request.CreateResponse(HttpStatusCode.OK, "Файл з Id " + header_id + " успішно видалений");
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetGridBranch([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, decimal? header_id)
        {
            try
            {
                if (header_id != null)
                {
                    IEnumerable<GridBranch> statisctic = _repository.GetGridBranch(header_id);
                    return Request.CreateResponse(HttpStatusCode.OK, statisctic.ToDataSourceResult(request));
                }
                else
                    return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage LoadFileTypes()
        {
            try
            {
                List<DropDown> statisctic = _repository.LoadFileTypes();
                return Request.CreateResponse(HttpStatusCode.OK, statisctic);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage LoadAgencyTypes()
        {
            try
            {
                List<DropDown> list = _repository.LoadAgencyTypes();
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage LoadAccTypes()
        {
            try
            {
                List<AccDropDown> list = _repository.LoadAccTypes();
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage LoadBranchTypes()
        {
            try
            {
                List<AccDropDown> list = _repository.LoadBranchTypes();
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetSocAgency(string branch, int agency_type)
        {
            try
            {
                List<DropDown> list = _repository.GetSocAgency(branch, agency_type);
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage LoadAgencyInGb(int agency_type)
        {
            try
            {
                List<DropDown> list = _repository.LoadAgencyInGb(agency_type);
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetDropDownValues(decimal header_id)
        {
            try
            {
                object obj = _repository.GetDropDownValues(header_id);
                return Request.CreateResponse(HttpStatusCode.OK, obj);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetUFilename()
        {
            try
            {
                string name = _repository.GetUFilename();
                return Request.CreateResponse(HttpStatusCode.OK, name);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }


        [HttpPost]
        public HttpResponseMessage UpdateGridBranch([FromBody] dynamic obj)
        {
            try
            {
                string branch = Convert.ToString(obj["branch"]);
                decimal header_id = Convert.ToDecimal(obj["header_id"]);
                int agency_id = Convert.ToInt32(obj["agency_id"]);
                _repository.UpdateGridBranch(header_id, branch, agency_id);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage InsertFileGrid([FromBody] dynamic row)
        {
            try
            {
                _repository.InsertFileGrid(row);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage InsertHeader([FromBody] AcceptedFiles obj)
        {
            try
            {
                string header_id = _repository.InsertHeader(obj);
                return Request.CreateResponse(HttpStatusCode.OK, header_id);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage UploadToTempDir()
        {
            HttpPostedFile file = HttpContext.Current.Request.Files[0];

            if (file != null && file.ContentLength > 0)
            {
                string TempDir = Path.GetTempPath() + "BankFile\\";
                DirectoryInfo TmpDitInf = new DirectoryInfo(TempDir);
                //-- если дериктории нету, то создаем ее
                if (!TmpDitInf.Exists)
                    TmpDitInf.Create();
                else
                {
                    Directory.Delete(TempDir, true);
                    TmpDitInf.Create();
                }
                string posFileName = file.FileName;
                string TempFile = posFileName.Substring(posFileName.LastIndexOf("\\") + 1);
                string TempPath = TempDir + TempFile;

                file.SaveAs(TempPath);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            else
                return Request.CreateResponse(HttpStatusCode.BadRequest, "Некоректний файл.");
        }

        [HttpPost]
        public HttpResponseMessage UpFile([FromBody] dynamic request)
        {
            try
            {
                string file = request.file_name;
                bool rbWin = request.rbWin;
                bool rbDos = request.rbDos;
                bool gb = request.gb;
                if (file != null)
                {
                    string TempDir = Path.GetTempPath() + "BankFile\\";
                    string TempPath = TempDir + file;
                    ArrayList arr = new ArrayList();
                    String line = String.Empty;

                    int encoding = 866;
                    if (rbDos) encoding = 866;
                    else if (rbWin) encoding = 1251;

                    StreamReader sr = new StreamReader(TempPath, Encoding.GetEncoding(encoding));

                    while (true)
                    {
                        line = sr.ReadLine();

                        if (line == null)
                            break;

                        arr.Add(line);
                    }

                    sr.Close();

                    var header = _repository.GetFileHeader(Convert.ToString(arr[0]));
                    List<ShowFile> info = new List<ShowFile>();

                    if (header.numInfo > arr.Count - 1)
                        throw new Exception("Недостатньо рядків у прийнятому банківському файлі!");
                    if (header.numInfo < arr.Count - 1)
                        throw new Exception("Надлишкові рядки у прийнятому банківському файлі!");

                    for (int i = 0; i < header.numInfo; i++)
                    {
                        info.Add(_repository.GetFileInfo(i + 1, Convert.ToString(arr[i + 1]), Convert.ToInt32(request.ddMonth), Convert.ToInt32(request.textYear)));
                    }
                    var type_id = Convert.ToDecimal(request.listTypes);
                    var AGENCY_TYPE = Convert.ToDecimal(request.listAgencyType);
                    var Acc_Type = Convert.ToString(request.ddAccType);
                    decimal header_id = 0;
                    if (gb)
                        header_id = _repository.WriteToDatabaseExt(false, header, info, type_id, AGENCY_TYPE, Acc_Type);
                    else
                        header_id = _repository.WriteToDatabaseExt(true, header, info, type_id, AGENCY_TYPE, Acc_Type);

                    //ShowRecords(bf);
                    Directory.Delete(TempDir, true);
                    return Request.CreateResponse(HttpStatusCode.OK, new { filename = header.filename, dat = header.dtCreated, header_id = header_id });//
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, "Некоректний файл.");
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex);
            }
        }

        [HttpPost]
        public HttpResponseMessage PayFile([FromBody] dynamic request)
        {
            string dat = request["dat"];
            string filename = Convert.ToString(request["filename"]);
            string header_id = Convert.ToString(request["header_id"]);
            bool gb = request["gb"];
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";


            var header = _repository.GetFileHeader(filename, Convert.ToDateTime(dat, cinfo), header_id);
            var param = _repository.GetParams(header_id);
            var info = _repository.GetFileInfo(header_id);
            string error = "";

            foreach (ShowFile fl in info)
            {
                if (fl.INCORRECT != 0 && fl.EXCLUDED != 1 && fl.MARKED4PAYMENT == 1)
                {
                    error += "Невалідна стрічка №" + fl.INFO_ID + "<br>";
                }
            }

            if (error.Length != 0)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, error);
            }
            try
            {
                if (gb)
                    _repository.PayGb(Convert.ToDecimal(request["agencyInGb"]), Convert.ToDecimal(header_id), param[0]);
                else
                    _repository.Pay(Convert.ToDecimal(header_id), param[0]);
                return Request.CreateResponse(HttpStatusCode.OK, new { filename = header.filename, dat = header.dtCreated, header_id = header_id });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage UpdateRow([FromBody] UpdateModel model)
        {
            try
            {
                _repository.UpdateRow(model);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage DeleteRow(decimal info_id)
        {
            try
            {
                _repository.DeleteRow(info_id);
                return Request.CreateResponse(HttpStatusCode.OK, "Файл з Id " + info_id + " успішно видалено.");
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetDepositBfRowCorrection([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, decimal info_id)
        {
            try
            {
                var data = _repository.GetDepositBfRowCorrection(info_id);
                return Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage Finish(decimal header_id)
        {
            try
            {
                _repository.Finish(header_id);
                return Request.CreateResponse(HttpStatusCode.OK, "Заголовок успішно оновлено.");
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }
}

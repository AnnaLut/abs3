using AttributeRouting.Web.Http;
using BarsWeb.Areas.PfuServer.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.PfuServer.Models;
using BarsWeb.Areas.PfuSync.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.PfuSync.SyncModels;
using Newtonsoft.Json;
using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http;

namespace BarsWeb.Areas.PfuServer.Controllers.Api
{
    public class ServerSyncController : ApiController
    {
        private IPfuServerRepository _repo;
        private IPfuSyncGZipRepository _gzip;
        public ServerSyncController(IPfuServerRepository repo, IPfuSyncGZipRepository gzip) {
            _repo = repo;
            _gzip = gzip;
        }

        [HttpPost]
        [POST("/api/pfuserver/serversync/sync")]
        public HttpResponseMessage Sync()
        {
            try
            {
                var syncParams = _repo.GetSyncRuParams();
                foreach (SyncRuParam syncParam in syncParams) {
                    if (syncParam.SYNC_ENABLED > 0) {
                        //Task.Run(() => {
                        //create sync task
                        StartSync(syncParam);
                        //});

                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, "Sync Start");
            }
            catch (Exception ex) {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        private RuResponse GetDataFromRu(string Url, string SyncMethod, decimal packSize)
        {
            try
            {
                string apiUrl = Url + "/api/pfuclient/regiondata/" + SyncMethod +
                    "?pack_size=" + packSize.ToString();
                byte[] byteArray = new byte[0];
                var ruRequest = WebRequest.Create(apiUrl);
                ruRequest.Method = "POST";
                ruRequest.ContentType = "application/json;charset='utf-8'";
                ruRequest.ContentLength = byteArray.Length;
                ruRequest.Timeout = 600000;
                Stream requestStream = ruRequest.GetRequestStream();
                requestStream.Write(byteArray, 0, byteArray.Length);
                requestStream.Close();

                HttpWebResponse response = (HttpWebResponse)ruRequest.GetResponse();
                Stream responseStream = response.GetResponseStream();
                var data = new StreamReader(responseStream).ReadToEnd();

                return JsonConvert.DeserializeObject<RuResponse>(data);
            }
            catch (Exception ex)
            {
                RuResponse err = new RuResponse();
                err.State = "Error";
                err.Error = ex.Message;
                return err;
            }
        }

        private RuResponse SendApproveToRu(string approve, string Table, string Url)
        {
            RuResponse reg = new RuResponse();
            reg.Data = _gzip.Compress(approve);
            reg.Tag = Table;
            byte[] byteArray = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(reg));
            string apiUrl = Url + "/api/pfuclient/regiondata/setapprove";
            var ruRequest = WebRequest.Create(apiUrl);
            ruRequest.Method = "POST";
            ruRequest.ContentType = "application/json;charset='utf-8'";
            ruRequest.ContentLength = byteArray.Length;
            ruRequest.Timeout = 600000;
            Stream requestStream = ruRequest.GetRequestStream();
            requestStream.Write(byteArray, 0, byteArray.Length);
            requestStream.Close();

            HttpWebResponse response = (HttpWebResponse)ruRequest.GetResponse();
            Stream responseStream = response.GetResponseStream();
            var data = new StreamReader(responseStream).ReadToEnd();

            return JsonConvert.DeserializeObject<RuResponse>(data);
        }

        private bool SyncTable(string Table, string SyncMethod, SyncRuParam syncParam)
        {
            decimal syncId = _repo.StartProtocol(syncParam.KF, syncParam.SYNC_SERVICE_URL, Table);
            try
            {
                decimal Total = 0, TransferCount = 0;
                do
                {
                    var ruResponse = GetDataFromRu(syncParam.SYNC_SERVICE_URL, SyncMethod, syncParam.PACK_SIZE);
                    if (ruResponse.State == "OK")
                    {
                        TransferCount += ruResponse.Total;
                        Total = ruResponse.Total;
                        if (ruResponse.Total > 0)
                        {
                            
                            string approve = "";
                            switch (Table) {
                                case "PENS":
                                    var pens = JsonConvert.DeserializeObject<PensionerQueue[]>(_gzip.Decompress(ruResponse.Data));
                                    approve = JsonConvert.SerializeObject(_repo.SavePensioner(pens));
                                    break;
                                case "PENSACC":
                                    var pensacc = JsonConvert.DeserializeObject<PensAccQueue[]>(_gzip.Decompress(ruResponse.Data));
                                    approve = JsonConvert.SerializeObject(_repo.SavePensAcc(pensacc));
                                    break;
                                default:
                                    throw new Exception("Unknown sync table");
                            }
                            
                            var ap = SendApproveToRu(approve, Table, syncParam.SYNC_SERVICE_URL);
                            if (ap.State != "OK")
                            {
                                _repo.ErrorProtocol(syncId,
                                    string.Format("Помилка підтверження синхронізації таблиці {0} з кліентом: {1} Опис помилки: {2}" +
                                    Table, syncParam.NAME,  ap.Error));
                                return false;
                            }
                        }
                    }
                    else
                    {
                        _repo.ErrorProtocol(syncId,
                            string.Format("Помилка синхронізації таблиці {0} з кліентом: {1} Опис помилки: {2}" +
                            Table, syncParam.NAME, ruResponse.Error));
                        return false;
                    }
                }
                while (Total > 0);
                _repo.StopProtocol(syncId, TransferCount);
            }
            catch (Exception ex)
            {
                _repo.ErrorProtocol(syncId, 
                    string.Format("Помилка звязку з кліентом:  {0} Опис помилки: {1}", syncParam.NAME, ex.Message));
            }

            return true;
        }

        private void StartSync(SyncRuParam syncParam)
        {
            //magic begin here!
            if (!SyncTable("PENS", "getpensionerqueue", syncParam)) return;
            if (!SyncTable("PENSACC", "getpensacc", syncParam)) return;
        }
    }
}
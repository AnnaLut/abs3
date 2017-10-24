using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Models;
using Oracle.DataAccess.Client;
using System.Data;
using System.Data.Objects;
using System.IO;
using System.Text;
using System.Drawing;
using Areas.BpkW4.Models;
using BarsWeb.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Implementation
{
    public class KievCardRepository: IKievCardRepository
    {
        private readonly W4Model _entities;
        private string _extractPath;
        private byte[] ImageToByteArray(Image imageIn)
        {
            MemoryStream ms = new MemoryStream();
            imageIn.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
            return ms.ToArray();
        }

        public KievCardRepository()
        {

            var connectionStr = EntitiesConnection.ConnectionString("BpkW4", "BpkW4");
            _entities = new W4Model(connectionStr);
        }
        
        public decimal ImportKievCardProjects(string extractPath)
        {
            _extractPath = extractPath;
            string[] filePaths = Directory.GetFiles(extractPath, "OpenPack_kk.xml");
            if (filePaths.Length == 0)
                throw new Exception("Не знайдено OpenPack_kk.xml файлу в архіві.");

            string xmlOpenPack = System.IO.File.ReadAllText(filePaths[0], Encoding.GetEncoding(1251));
            

            OracleParameter[] parameters =
                {
                    new OracleParameter("p_filename", OracleDbType.Varchar2, "OpenPack_kk.xml", ParameterDirection.Input),
                    new OracleParameter("p_filebody", OracleDbType.Clob, xmlOpenPack, ParameterDirection.Input),
                    new OracleParameter("p_fileid", OracleDbType.Decimal, 200){Direction = ParameterDirection.ReturnValue},
                    new OracleParameter("p_flag_kk", OracleDbType.Decimal, 1, ParameterDirection.Input)  
                };
            string sql = @"begin 
                                bars_ow.w4_import_salary_file(:p_filename, :p_filebody, :p_fileid, :p_flag_kk);
                            end;";
            _entities.ExecuteStoreCommand(sql, parameters);
            return Convert.ToDecimal(parameters[2].Value.ToString());
        }

        public IEnumerable<KievCardImported> GetImportedProjects(decimal id) 
        {
            if (_extractPath == "")
            {
                throw new Exception("Даний проект ще не імпортований");
            }

            OracleParameter[] parameters =
                {
                    new OracleParameter("id", OracleDbType.Decimal, id, ParameterDirection.Input)
                };
            string sql = @"select * 
                            from v_ow_salary_data 
                            where id = :id";
            var importedProjects = _entities.ExecuteStoreQuery<KievCardImported>(sql, parameters);
            foreach (KievCardImported project in importedProjects)
            {
                string resultImage = "";
                string[] images = Directory.GetFiles(_extractPath, "*.JPG");
                string[] imagesNames = new string[images.Length];
                for (int i = 0; i < images.Length; i++ )
                {
                    imagesNames[i] = images[i].Split(new char[] { @"\"[0], @"/"[0]}).Last().Split(new char[] {@"."[0]})[0];
                    
                    if ((imagesNames[i].Equals(project.Okpo)) || 
                        (imagesNames[i].Equals(project.PaspSeries + project.PaspNum)) || 
                        (imagesNames[i].Equals(project.Okpo + "_" + project.PaspSeries + project.PaspNum)))
                    {
                        resultImage = images[i];
                        
                    }
                }

                const string sqlImg = @"begin 
                                    bars_ow.set_salary_photo(:p_id, :p_idn, :p_photo);
                                end;";
                /* Якщо ми знайшли фотку */
                if (resultImage.Length != 0) 
                {
                    Image current = Image.FromFile(resultImage);
                    if ((current.Width != 480) || (current.Height != 640))
                    {
                        current = new Bitmap(current, new Size(480, 640));
                    }
                    byte[] oraImg = ImageToByteArray(current);

                    OracleParameter[] parametersImg =
                    {
                        new OracleParameter("p_id", OracleDbType.Decimal, id, ParameterDirection.Input),
                        new OracleParameter("p_idn", OracleDbType.Decimal, project.Idn, ParameterDirection.Input),
                        new OracleParameter("p_photo", OracleDbType.Blob, oraImg, ParameterDirection.Input)
                    };              
                    _entities.ExecuteStoreCommand(sqlImg, parametersImg);
                }
                /* Якщо фотки нема */
                else
                {
                    OracleParameter[] parametersImg =
                    {
                        new OracleParameter("p_id", OracleDbType.Decimal, id, ParameterDirection.Input),
                        new OracleParameter("p_idn", OracleDbType.Decimal, project.Idn, ParameterDirection.Input),
                        new OracleParameter("p_photo", OracleDbType.Blob, null, ParameterDirection.Input)
                    };
                    _entities.ExecuteStoreCommand(sqlImg, parametersImg);
                }
            }
            return _entities.ExecuteStoreQuery<KievCardImported>(sql, parameters);
        }

        public IQueryable<STAFF> GetStaff(string branch)
        {
            return _entities.STAFF.Where(s => branch == null || s.BRANCH == branch);
        }


        public IQueryable<V_W4_PRODUCTGRP_KK> GetGroups()
        {
            return _entities.V_W4_PRODUCTGRP_KK;
        }


        public IQueryable<V_W4_PRODUCT_KK> GetOtherProducts(string prodGrp)
        {
            return _entities.V_W4_PRODUCT_KK.Where(c => prodGrp == null || c.GRP_CODE == prodGrp);
        }

        public IQueryable<V_BPK_PROECT_KK> GetSalaryProducts(string prodGrp)
        {
            return _entities.V_BPK_PROECT_KK.Where(c => prodGrp == null || c.GRP_CODE == prodGrp); ;
        }


        public IQueryable<V_W4_CARD_KK> GetCards(string product)
        {
            return _entities.V_W4_CARD_KK.Where(c => product == null || c.PRODUCT_CODE == product);
        }


        public Ticket SaveFile(PackageParams fileParams)
        {
            const string sqlCheck = @"begin bars_ow.check_salary_opencard(:p_id, :p_cardcode); end;";
            OracleParameter[] parametersCheck =
                    {
                        new OracleParameter("p_id", OracleDbType.Decimal) {Value = fileParams.FileId},
                        new OracleParameter("p_cardcode", OracleDbType.Varchar2) {Value = fileParams.CardId}
                    };
            _entities.ExecuteStoreCommand(sqlCheck, parametersCheck);


            var ticketName = new ObjectParameter("p_ticketname", typeof (string));
            var ticketBody = new ObjectParameter("p_ticketbody", typeof (string));
            _entities.BARS_OW_W4_CREATE_SALARY_DEAL(
                fileParams.FileId,
                fileParams.ProjectId,
                fileParams.CardId,
                fileParams.Branch,
                fileParams.ExecutorId,
                ticketName,
                ticketBody);

            object[] parameters =
                {
                    new OracleParameter("p_id", OracleDbType.Decimal) {Value = fileParams.FileId}
                };

            return new Ticket()
            {
                Name = ticketName.Value.ToString(),
                Body = ticketBody.Value.ToString()
            }; 
        }

        public IEnumerable<OwSalaryData> GetSalaryData(decimal fileId, DataSourceRequest request)
        {
            object[] parameters =
                {
                    new OracleParameter("p_id", OracleDbType.Decimal) {Value = fileId}
                };
            return _entities.ExecuteStoreQuery<OwSalaryData>("select * from V_OW_SALARY_DATA where id = :p_fileid",
                parameters);
        }

        public string GetReceiptForFile(decimal fileId)
        {
            object[] parameters =
                {
                    new OracleParameter("p_id", OracleDbType.Decimal) {Value = fileId}
                };
            return
                _entities.ExecuteStoreQuery<string>("select FILE_DATA from ow_impfile where ID = :p_fileid", parameters)
                    .SingleOrDefault();
        }
    }
}

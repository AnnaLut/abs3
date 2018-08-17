using Bars.EAD.Models;
using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace Bars.EAD.Messages
{
    /// <summary>
    /// Сообщение ЕА - из очереди синхронизации
    /// </summary>
    public class SyncMessage : SessionMessage
    {
        private DateTime _CrtDate;
        private String _TypeID;
        private String _ObjID;

        [JsonIgnore]
        public String TypeID
        {
            get
            {
                return this._TypeID;
            }
        }
        [JsonIgnore]
        public String ObjID
        {
            get
            {
                return this._ObjID;
            }
        }

        public SyncMessage(Int64 ID, String SessionID, OracleConnection con, String kf) : base(SessionID, GetMethodByID(ID, con), ID)
        {
            Init(con, kf);
            InitParams(con);
        }

        public SyncMessage(SyncQueueRow item, String SessionID, OracleConnection con, String kf, string method)
            : base(SessionID, method, item.Id)
        {
            this._CrtDate = (DateTime)item.CreateDate;
            this._TypeID = item.TypeId;
            this._ObjID = item.ObjId;

            InitParams(con);
        }

        private void Init(OracleConnection con, String kf)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = @"select sq.crt_date, sq.type_id, sq.obj_id
                                  from ead_sync_queue sq, ead_types t
                                 where sq.id = :p_sync_id
                                   and sq.type_id = t.id
                                   and sq.kf = :p_kf";
                cmd.Parameters.Add("p_sync_id", OracleDbType.Int64, this._ID, ParameterDirection.Input);
                cmd.Parameters.Add("p_kf", OracleDbType.Int64, kf, ParameterDirection.Input);

                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        this._CrtDate = Convert.ToDateTime(rdr["crt_date"]);
                        this._TypeID = Convert.ToString(rdr["type_id"]);
                        this._ObjID = Convert.ToString(rdr["obj_id"]);
                    }
                }
            }
        }
        private void InitParams(OracleConnection con)
        {
            switch (this.TypeID)
            {
                case "DOC":
                    this._Params = new Object[1] { Structs.Params.Document.GetInstance(this._ObjID, con) };
                    break;
                case "CLIENT":
                    this._Params = new Object[1] { Structs.Params.Client.GetInstance(this._ObjID, con) };
                    break;
                case "AGR":
                    this._Params = new Object[1] { Structs.Params.Agreement.GetInstance(this._ObjID, con) };
                    break;
                case "UAGR":
                    this._Params = new Object[1] { Structs.Params.UAgreement.GetInstance(this._ObjID, con) };
                    break;
                case "ACT":
                    this._Params = new Object[1] { Structs.Params.Actualization.GetInstance(this._ObjID, con) };
                    break;
                case "ACC":
                    this._Params = new Object[1] { Structs.Params.Account.GetInstance(this._ObjID, con) };//счета клиента-физ.лица
                    break;
                case "UACC":
                    this._Params = new Object[1] { Structs.Params.UAccount.GetInstance(this._ObjID, con) };//счета клиента-юр.лица
                    break;
                case "DICT":
                    this._Params = Structs.Params.Dictionary.GetData(this._ObjID, con);
                    break;
                case "UCLIENT":
                    this._Params = new Object[1] { Structs.Params.UClient.GetInstance(this._ObjID, con) };//Отдельный класс для клиентов юр.лиц в связи с разным подходом к формированию сообщения.
                    break;
            }
        }

        public static String GetMethodByID(Int64 ID, OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = @"select t.method
                                  from ead_sync_queue sq, ead_types t
                                 where sq.id = :p_sync_id
                                   and sq.type_id = t.id";
                cmd.Parameters.Add("p_sync_id", OracleDbType.Int64, ID, ParameterDirection.Input);

                return Convert.ToString(cmd.ExecuteScalar());
            }
        }
    }
}
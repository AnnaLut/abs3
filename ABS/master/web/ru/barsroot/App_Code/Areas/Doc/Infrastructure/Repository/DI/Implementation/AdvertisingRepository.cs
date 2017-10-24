using System;
using System.Collections.Generic;
using System.Data.Objects;
using Areas.Doc.Models;
using BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Abstract;
using System.Linq;
using BarsWeb.Areas.Doc.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Implementation
{
    public class AdvertisingRepository : IAdvertisingRepository
    {
        readonly DocEntities _entities;
        public AdvertisingRepository(IDocModel model)
        {
		    _entities = model.DocEntities;
        }

        public IQueryable<TicketsAdvertising> GetAllAdvertising()
        {
            return _entities.TICKETS_ADVERTISING.Select(i=>new TicketsAdvertising
            {
                Id = i.ID,
                Name = i.NAME,
                DateBegin = i.DAT_BEGIN,
                DateEnd = i.DAT_END,
                IsActive = i.ACTIVE,
                DataBodyHtml = i.DATA_BODY_HTML,
                DataBody = i.DATA_BODY,
                Description = i.DESCRIPTION,
                //UserId = i.USERID,
                //Branch = i.BRANCH,
                BranchList = i.TICKETS_ADVERTISING_BRANCH.Select(r=>r.BRANCH).OrderBy(e=>e),
                TransactionCodeList = i.TRANSACTION_CODE_LIST,
                IsDefault = i.DEF_FLAG,
                Kf = i.KF,
                Width = (int?)i.WIDTH,
                Height = (int?)i.HEIGHT
            }).OrderBy(i=>i.Id);
        }

        public TicketsAdvertising GetAdvertising(int id)
        {
            var advertising = GetAllAdvertising().FirstOrDefault(i=>i.Id == id);
            if (advertising != null)
            {
                advertising.Type = (advertising.DataBodyHtml == null && advertising.DataBody != null) ? 2 : 1;
                advertising.BranchList =
                    _entities.TICKETS_ADVERTISING_BRANCH.Where(r => r.ADVERTISING_ID == id)
                        .Select(r => r.BRANCH)
                        .ToArray();
            }
            return advertising;
        }

        public int AddAdvertising(TicketsAdvertising advertising)
        {
            return SetAdversiting(advertising);
        }

        public int EditAdvertising(TicketsAdvertising advertising)
        {
            return SetAdversiting(advertising);
        }

        private int SetAdversiting(TicketsAdvertising advertising)
        {
            var id = new ObjectParameter("p_id", typeof(decimal)){Value = advertising.Id};
            _entities.ADVT_PACK_SET_ADVT(
                p_ID:id,
                p_NAME:advertising.Name,
                p_DAT_BEGIN:advertising.DateBegin,
                p_DAT_END:advertising.DateEnd,
                p_ACTIVE:advertising.IsActive,
                p_DATA_BODY_HTML:advertising.DataBodyHtml,
                p_DATA_BODY: advertising.DataBody,
                p_DESCRIPTION:advertising.Description,
                //p_USERID:advertising.UserId,
                //p_BRANCH:advertising.Branch,
                p_TRANSACTION_CODE_LIST:advertising.TransactionCodeList,
                p_DEF_FLAG:advertising.IsDefault,
                p_WIDTH:advertising.Width,
                p_HEIGHT:advertising.Height);

            var newId = Convert.ToInt32(id.Value);
            UpdateBranchList(newId, advertising.BranchList);
            
            return newId;
        }

        public void UpdateBranchList(int id, IEnumerable<string> branchList)
        {
            var ticket = _entities.TICKETS_ADVERTISING.FirstOrDefault(i=> i.ID == id);
            if (ticket != null)
            {
                const string deleteSql = "delete from TICKETS_ADVERTISING_BRANCH where ADVERTISING_ID = :p_id";
                object[] parameters =
                {
                    new OracleParameter("p_id", OracleDbType.Decimal).Value = id
                };
                _entities.ExecuteStoreCommand(deleteSql, parameters);
            }

            foreach (var item in branchList)
            {
                object[] insertParameters =
                {
                    new OracleParameter("p_id", OracleDbType.Decimal).Value = id,
                    new OracleParameter("p_branch", OracleDbType.Varchar2).Value = item
                };
                const string insertSql = "insert into TICKETS_ADVERTISING_BRANCH values (:p_id, :p_branch)";

                _entities.ExecuteStoreCommand(insertSql, insertParameters);
            } 
            _entities.SaveChanges();
            
        }

        public decimal? ValidateIsExistAdvertising(
            decimal? id, 
            DateTime? dateBegin, 
            DateTime? dateEnd, 
            string branch, 
            string transactionCodeList)
        {
            TICKETS_ADVERTISING advt;
            if (id != null)
            {
                advt = _entities.TICKETS_ADVERTISING.FirstOrDefault(i =>
                    i.ID != id
                    && ((dateBegin >= i.DAT_BEGIN && dateBegin <= i.DAT_END)
                        || (dateEnd >= i.DAT_BEGIN && dateEnd <= i.DAT_END))
                    && i.ACTIVE == "Y"
                    && i.TICKETS_ADVERTISING_BRANCH.FirstOrDefault(r => r.BRANCH == branch) != null
                    && i.TRANSACTION_CODE_LIST == transactionCodeList);
            }
            else
            {
                advt = _entities.TICKETS_ADVERTISING.FirstOrDefault(i =>
                    ((dateBegin >= i.DAT_BEGIN && dateBegin <= i.DAT_END)
                        || (dateEnd >= i.DAT_BEGIN && dateEnd <= i.DAT_END))
                    && i.ACTIVE == "Y"
                    && i.TICKETS_ADVERTISING_BRANCH.FirstOrDefault(r => r.BRANCH == branch) != null
                    && i.TRANSACTION_CODE_LIST == transactionCodeList);
            }

            if (advt == null)
            {
                return null;
            }
            return advt.ID;
        }

        public bool DeleteAdvertising(int id)
        {
            var adversiting = GetAdvertising(id);
            if (adversiting != null)
            {
                adversiting.IsActive = "N";
                SetAdversiting(adversiting);
                //_entities.TICKETS_ADVERTISING.DeleteObject(adversiting);
                //_entities.SaveChanges();
                return true;
            }
            return false;
        }


        /*public DateTime GetBankDate()
        {
            var date = _entities.ExecuteStoreQuery<DateTime>("SELECT bankdate FROM dual").FirstOrDefault();
            return date;
        }*/
    }
}
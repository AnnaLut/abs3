using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    /// <summary>
    /// Summary description for ILimitsDirParticipants
    /// </summary>
    public interface ILimitsDirParticipants
    {
        List<SepParticipantsModel> GetAllParticipantLock();
        List<SepParticipantsHistoryModel> GetAllParticipantLockHistory(string mfo);
        void SaveAllParticipantChanges(List<SepParticipantsModel> changedData);
        void CreateFlagFIle();
    }
}
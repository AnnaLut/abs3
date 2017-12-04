using System.Linq;
using BarsWeb.Areas.CreditUi.Models;
using System;
using System.Collections.Generic;


namespace BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract
{
    public interface IglkRepository
    {
        IQueryable<GLK> GetGLK(decimal nd);
        glkStaticData GetStaticData(decimal nd);
        void BalanceGLK(decimal nd);
        void CreateGLKProject(decimal nd, decimal acc);
        void PreGpkOpen(decimal nd);
        IQueryable<glkArchive> GetArchive(decimal nd);
        IQueryable<glkArchiveBody> GetArchiveBody(decimal id);
        void RestoreGLK(decimal id);
        void GroupUpdateGLK(int mode, List<UpdateGLK> list_glk);
    }
}
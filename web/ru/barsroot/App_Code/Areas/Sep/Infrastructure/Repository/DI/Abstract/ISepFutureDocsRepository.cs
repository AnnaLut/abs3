using BarsWeb.Areas.Sep.Models;
using System;
using System.Linq;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface ISepFutureDocsRepository
	{
        SepFutureDocAccount GetSepFutureDocAccount(decimal? ref_);
        void SetSepFutureDoc(decimal? ref_, DateTime? datd);
        void RemoveSepFutureDoc(decimal? ref_);
        IQueryable<SepFutureDoc> GetSepFutureDoc();
	}
}
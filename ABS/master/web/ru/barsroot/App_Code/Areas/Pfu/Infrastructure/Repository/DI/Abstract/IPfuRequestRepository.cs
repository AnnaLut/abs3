using BarsWeb.Areas.Pfu.Models.ApiModels;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract
{
    /// <summary>
    /// Summary description for IPfuRequestRepository
    /// </summary>
    public interface IPfuRequestRepository
    {
        ResponseData InsertPackage(decimal packageId, string packageName, string packageMfo, byte[] packageData);

        ResponseData CheckPackage(decimal packageId);

        ResponseData ReceiptPackage(decimal packageId);
    }
}
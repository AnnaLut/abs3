using BarsWeb.Areas.Transp.Models.ApiModels;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Transp.Infrastructure.DI.Abstract
{
    /// <summary>
    /// Summary description for ITranspRepository
    /// </summary>
    public interface ITranspRepository
    {
        ResponseData InsertPackage(decimal packageId, string packageName, string packageMfo, byte[] packageData);

        ResponseData CheckPackage(decimal packageId);

        ResponseData ReceiptPackage(decimal packageId);
    }
}
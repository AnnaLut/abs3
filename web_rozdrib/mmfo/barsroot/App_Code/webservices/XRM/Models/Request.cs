using System;

namespace Bars.WebServices.XRM.Models
{
    /// <summary>
    /// default params that should be passed everytime
    /// where T : class
    /// </summary>
    public class XRMRequest<T> : IRequest where T : class, new()
    {
        public decimal TransactionId { get; set; }
        public string UserLogin { get; set; }
        public short? OperationType { get; set; }

        public T AdditionalData { get; set; }
    }

    public interface IRequest
    {
        decimal TransactionId { get; set; }
        string UserLogin { get; set; }
        short? OperationType { get; set; }
    }
}
using System.Collections.Generic;

namespace BarsWeb.Core.Models
{
    public class ODataMetadata<T> where T : class
    {
        private readonly long? _total;
        private IEnumerable<T> _data;

        public ODataMetadata(IEnumerable<T> result, long? total)
        {
            _total = total;
            _data = result;
        }

        public IEnumerable<T> Data
        {
            get { return _data; }
        }

        public long? Total
        {
            get { return _total; }
        }
    }
}

using System;
using System.Net.Http;
using System.Net.Http.Headers;

namespace BarsWeb.Areas.CDO.Common.DataContexts
{
    internal class HttpDataContext : IHttpDataContext, IDisposable
    {
        private HttpClient _dataProvider;
        private string _baseApiUrl;

        public HttpDataContext(string baseApiUrl)
        {
            _baseApiUrl = baseApiUrl;
        }

        public HttpClient GetProvider()
        {
            return GetProvider(null);
        }

        public HttpClient GetProvider(AuthenticationHeaderValue authentication)
        {
            if (_dataProvider == null)
            {
                _dataProvider = new HttpClient
                {
                    BaseAddress = new Uri(_baseApiUrl)
                };
                _dataProvider.DefaultRequestHeaders.Accept.Clear();
                _dataProvider.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                if (authentication != null)
                {
                    _dataProvider.DefaultRequestHeaders.Authorization = authentication;
                }
            }

            return _dataProvider;

        }

        public void Dispose()
        {
            if (_dataProvider != null)
            {
                _dataProvider.Dispose();
            }
        }
    }
    public interface IHttpDataContext
    {
        HttpClient GetProvider();
        HttpClient GetProvider(AuthenticationHeaderValue authentication);
    }
}
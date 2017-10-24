using System;

namespace BarsWeb.Areas.Security.Infrastructure.Repository
{
    /// <summary>
    /// Ошибки аутентификации
    /// </summary>
    public class AutenticationException : Exception
    {
        public AutenticationException(string message)
            : base(message)
        {
        }

        public AutenticationException(string message, Exception ex)
            : base(message, ex)
        {
        }
    }
}
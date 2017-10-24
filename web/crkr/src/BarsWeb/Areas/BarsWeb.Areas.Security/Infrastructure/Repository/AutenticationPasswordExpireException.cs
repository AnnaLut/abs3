namespace BarsWeb.Areas.Security.Infrastructure.Repository
{
    /// <summary>
    /// ���� �������� �����
    /// </summary>
    public class AutenticationPasswordExpireException : AutenticationException
    {
        public AutenticationPasswordExpireException(string message)
            : base(message)
        {
        }

        public AutenticationPasswordExpireException(string message, System.Exception ex)
            : base(message, ex)
        {
        }
    }
}
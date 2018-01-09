using Oracle.DataAccess.Types;

namespace Bars.Oracle
{
    public abstract class OracleNullableCustomType<T> : INullable
        where T : OracleNullableCustomType<T>, new()
    {
        public bool IsNull { get; protected set; }

        public static T Null
        {
            get { return new T() { IsNull = true }; }
        }
    }

    public class OracleCustomTypeFactory<T> : IOracleCustomTypeFactory
        where T : IOracleCustomType, new()
    {
        public IOracleCustomType CreateObject()
        {
            return new T();
        }
    }
}
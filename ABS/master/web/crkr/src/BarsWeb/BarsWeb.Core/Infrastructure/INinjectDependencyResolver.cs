using Ninject;

namespace BarsWeb.Core.Infrastructure
{
    public interface INinjectDependencyResolver
    {
        IKernel GetKernel();
    }
}
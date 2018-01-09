using Areas.Reference.Models;
using BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Abstract;
using System.Linq;
using BarsWeb.Areas.Reference.Models;

namespace BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Implementation
{
    public class HandBookMetadataRepository : IHandBookMetadataRepository
    {
        readonly ReferenceEntities _entities;
        public HandBookMetadataRepository(IReferenceModel model)
        {
            _entities = model.ReferenceEntities;
        }
        public IQueryable<HandBook> GetHandBookList()
        {
            var books = _entities.META_TABLES.Select(i=>new HandBook
            {
                Id = (int)i.TABID,
                Name = i.TABNAME,
                Semantic = i.SEMANTIC,
                IsRelation = (i.TABRELATION == 1),
                IsDeleted = (i.TABLDEL == 1)
            });
            return books;
        }

        public HandBook GetHandBookByName(string name)
        {
            var upperName = name.ToUpper();
            return _entities.META_TABLES.Select(i => new HandBook
            {
                Id = (int)i.TABID,
                Name = i.TABNAME,
                Semantic = i.SEMANTIC,
                IsRelation = (i.TABRELATION == 1),
                IsDeleted = (i.TABLDEL == 1),
                Columns = i.META_COLUMNS.Select(r=>new HandBookColumn
                {
                    Id = (int)r.COLID,
                    HandBookId = (int)r.TABID,
                    Name  = r.COLNAME,
                    Type  = r.COLTYPE,
                    Semantic = r.SEMANTIC,
                    ShowWidth = (int?)r.SHOWWIDTH,
                    ShowMaxChar  = r.SHOWMAXCHAR,
                    ShowPosition = r.SHOWPOS,
                    IsShowInRow = (r.SHOWIN_RO == 1),
                    IsShowRetVal = (r.SHOWRETVAL == 1),
                    IsSemantic = (r.INSTNSSEMANTIC == 1),
                    IsExtrnVal = (r.EXTRNVAL == 1),
                    ShowRelCType = r.SHOWREL_CTYPE,
                    ShowFormat = r.SHOWFORMAT,
                    IsShowInFilter = (r.SHOWIN_FLTR == 1),
                    IsShowReference = (r.SHOWREF == 1),
                    ShowResult = r.SHOWRESULT,
                    CaseSensitive = r.CASE_SENSITIVE,
                    IsNotToEdit  = (r.NOT_TO_EDIT == 1),
                    IsNotToShow  = (r.NOT_TO_SHOW == 1),
                    IsSimpleFilter = (r.SIMPLE_FILTER == 1),
                    FormName = r.FORM_NAME,
                }).OrderBy(r=>r.ShowPosition)
            }).FirstOrDefault(e => e.Name == upperName);
        }

        public HandBook GetHandBook(int id)
        {
            return _entities.META_TABLES.Select(i => new HandBook
            {
                Id = (int)i.TABID,
                Name = i.TABNAME,
                Semantic = i.SEMANTIC,
                IsRelation = (i.TABRELATION == 1),
                IsDeleted = (i.TABLDEL == 1),
                Columns = i.META_COLUMNS.Select(r => new HandBookColumn
                {
                    Id = (int)r.COLID,
                    HandBookId = (int)r.TABID,
                    Name = r.COLNAME,
                    Type = r.COLTYPE,
                    Semantic = r.SEMANTIC,
                    ShowWidth = (int?)r.SHOWWIDTH,
                    ShowMaxChar = r.SHOWMAXCHAR,
                    ShowPosition = r.SHOWPOS,
                    IsShowInRow = (r.SHOWIN_RO == 1),
                    IsShowRetVal = (r.SHOWRETVAL == 1),
                    IsSemantic = (r.INSTNSSEMANTIC == 1),
                    IsExtrnVal = (r.EXTRNVAL == 1),
                    ShowRelCType = r.SHOWREL_CTYPE,
                    ShowFormat = r.SHOWFORMAT,
                    IsShowInFilter = (r.SHOWIN_FLTR == 1),
                    IsShowReference = (r.SHOWREF == 1),
                    ShowResult = r.SHOWRESULT,
                    CaseSensitive = r.CASE_SENSITIVE,
                    IsNotToEdit = (r.NOT_TO_EDIT == 1),
                    IsNotToShow = (r.NOT_TO_SHOW == 1),
                    IsSimpleFilter = (r.SIMPLE_FILTER == 1),
                    FormName = r.FORM_NAME,
                }).OrderBy(r => r.ShowPosition)
            }).FirstOrDefault(e => e.Id == id);
        }

        public IQueryable<HandBookColumn> GetHandBookColumns(int handBookId)
        {
            return _entities.META_COLUMNS.Select(r => new HandBookColumn
            {
                Id = (int)r.COLID,
                HandBookId = (int)r.TABID,
                Name = r.COLNAME,
                Type = r.COLTYPE,
                Semantic = r.SEMANTIC,
                ShowWidth = (int?)r.SHOWWIDTH,
                ShowMaxChar = r.SHOWMAXCHAR,
                ShowPosition = r.SHOWPOS,
                IsShowInRow = (r.SHOWIN_RO == 1),
                IsShowRetVal = (r.SHOWRETVAL == 1),
                IsSemantic = (r.INSTNSSEMANTIC == 1),
                IsExtrnVal = (r.EXTRNVAL == 1),
                ShowRelCType = r.SHOWREL_CTYPE,
                ShowFormat = r.SHOWFORMAT,
                IsShowInFilter = (r.SHOWIN_FLTR == 1),
                IsShowReference = (r.SHOWREF == 1),
                ShowResult = r.SHOWRESULT,
                CaseSensitive = r.CASE_SENSITIVE,
                IsNotToEdit = (r.NOT_TO_EDIT == 1),
                IsNotToShow = (r.NOT_TO_SHOW == 1),
                IsSimpleFilter = (r.SIMPLE_FILTER == 1),
                FormName = r.FORM_NAME,
            }).Where(i => i.HandBookId == handBookId).OrderBy(r => r.ShowPosition);
        }

    }
}
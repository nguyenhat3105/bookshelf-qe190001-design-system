"""Build the private submission report from actual captured screen images."""
import json
from pathlib import Path
from docx import Document
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_CELL_VERTICAL_ALIGNMENT
from docx.oxml import OxmlElement
from docx.oxml.ns import qn

root = Path(__file__).resolve().parents[1]
screens = root / 'artifacts' / 'screenshots'
output = root.parent / 'submission-QE190001' / 'QE190001.docx'
credentials = json.loads((root / 'test-account.local.json').read_text(encoding='utf-8'))
items = [
    ('firebase-auth', 'Firebase console — Authentication', 'The Users list includes the dedicated grader account.'),
    ('firebase-data', 'Firebase console — Firestore data', 'The books collection contains five sample books belonging to the grader account.'),
    ('firebase-rules', 'Firebase console — Security Rules', 'The published rules restrict access by owner and validate canonical book IDs and field values.'),
    ('firebase-rules-access', 'Firebase console Security Rules access controls', 'The active rules allow signed-in users to read and change only their own books and validate every saved document.'),
    ('firebase-rules-published', 'Firebase console published Rules version', 'The starred version is the active Rules release published for this project.'),
    ('01-home', 'Home screen', 'The public Home screen shows BookShelf, Login, Register and the feature cards.'),
    ('01b-home-features', 'Home screen feature cards', 'Three feature cards describe tracking books, reading status and favorites.'),
    ('02-register-validation', 'Register screen — validation', 'Submitting the empty registration form shows the required-field messages.'),
    ('03-register-success', 'Register screen — success', 'A real Firebase account was created and Registration successful is displayed.'),
    ('05-login', 'Login screen', 'The empty sign-in form.'),
    ('06-list-after-login', 'List screen — after login', 'The signed-in account, Logout action and saved books are shown.'),
    ('07-add-validation', 'Add Book form — validation', 'Submitting an empty book form shows the required-field messages.'),
    ('08-add-success', 'Add Book form — success', 'Book added is shown after the new book is saved.'),
    ('14-genre-filter', 'Filters and search — genre filter', 'Selecting Fiction limits the visible books to that genre.'),
    ('15-status-filter', 'Filters and search — status filter', 'Reading combines with the genre filter.'),
    ('16-favorites-filter', 'Filters and search — favorites only', 'With Fiction and All statuses selected, Favorites only reduces the matching set from three books to two.'),
    ('17-search', 'Filters and search — search', 'The title search combines with all active filters and ignores surrounding spaces.'),
    ('18-summary', 'Summary', 'Books and Favorites counts and the status breakdown describe the books currently shown.'),
    ('09-detail-view', 'Detail screen — view mode', 'Title, author, genre, status, rating and notes are displayed.'),
    ('10-detail-edit-validation', 'Detail screen — edit mode validation', 'Saving an empty title displays Title is required.'),
    ('11-detail-after-save', 'Detail screen — after Save', 'The revised notes are saved and the screen returns to view mode.'),
    ('12-favorite-before', 'Favorite toggle — before', 'The verification book is not yet marked as a favorite.'),
    ('13-favorite-after', 'Favorite toggle — after', 'The filled star indicates the favorite value saved in Firestore.'),
    ('19-delete-confirmation', 'Delete — confirmation', 'The confirmation dialog provides Cancel and Delete actions.'),
    ('20-after-delete', 'Delete — after', 'The verification book is removed and the original five books remain.'),
    ('04-empty-state', 'Empty state', 'A fresh second account displays No books found.'),
]
missing = [name for name, _, _ in items if not (screens / f'{name}.png').exists()]
if missing:
    raise SystemExit('Missing actual screenshots: ' + ', '.join(missing))

doc = Document()
section = doc.sections[0]
section.top_margin = section.bottom_margin = Inches(.6)
section.left_margin = section.right_margin = Inches(.65)
section.page_width, section.page_height = Inches(8.27), Inches(11.69)
for name in ['Normal', 'Title', 'Heading 1', 'Heading 2']:
    style = doc.styles[name]
    style.font.name = 'Arial'
    style.font.size = Pt(11 if name == 'Normal' else 16)
    style.font.color.rgb = RGBColor(0, 0, 0)
doc.styles['Normal'].paragraph_format.space_after = Pt(10)

# Keep the exact field names and order required by the exam template.
doc.add_paragraph('BookShelf Submission Information', style='Title')
for border in list(doc.styles['Title'].element.iter(qn('w:pBdr'))):
    border.getparent().remove(border)
table = doc.add_table(rows=1, cols=2)
table.autofit = False
table.columns[0].width = Inches(2.05)
table.columns[1].width = Inches(4.92)
table.cell(0,0).text = 'Field'
table.cell(0,1).text = 'Information'
for line in [
    'Student Code: QE190001',
    'Full Name: Nguyễn Ngọc Như Ngân',
    'GitHub Repository URL: https://github.com/nguyenhat3105/bookshelf-qe190001-design-system',
    'APK Download Link: https://github.com/nguyenhat3105/bookshelf-qe190001-design-system/releases/download/v1.0.0/app-release.apk',
    'Firebase Project ID: bookshelf-qe190001',
    f'Test account email: {credentials["email"]}',
    f'Test account password: {credentials["password"]}',
]:
    label, value = line.split(': ',1)
    cells = table.add_row().cells
    cells[0].text = label
    cells[1].text = value

for i,row in enumerate(table.rows):
    row._tr.get_or_add_trPr().append(OxmlElement('w:cantSplit'))
    for j,cell in enumerate(row.cells):
        cell.width = Inches(2.05 if j == 0 else 4.92)
        cell.vertical_alignment = WD_CELL_VERTICAL_ALIGNMENT.CENTER
        pr = cell._tc.get_or_add_tcPr()
        shade = OxmlElement('w:shd')
        shade.set(qn('w:fill'), '244B60' if i == 0 else ('F2F5F7' if i % 2 else 'FFFFFF'))
        pr.append(shade)
        margins=OxmlElement('w:tcMar')
        for side in ['top','bottom','left','right']:
            node=OxmlElement('w:'+side)
            node.set(qn('w:w'),'150')
            node.set(qn('w:type'),'dxa')
            margins.append(node)
        pr.append(margins)
        for p in cell.paragraphs:
            p.paragraph_format.space_after=Pt(0)
            p.paragraph_format.line_spacing=1.1
            for run in p.runs:
                run.font.size=Pt(10.5)
                run.bold=i==0 or j==0
                run.font.color.rgb=RGBColor.from_string('FFFFFF' if i==0 else '000000')
borders=OxmlElement('w:tblBorders')
for edge in ['top','bottom','left','right','insideH','insideV']:
    node=OxmlElement('w:'+edge)
    for key,value in [('val','single'),('sz','6'),('color','D9D9D9')]:
        node.set(qn('w:'+key),value)
    borders.append(node)
table._tbl.tblPr.append(borders)

for name, caption, explanation in items:
    doc.add_page_break()
    doc.add_heading(caption, level=1)
    doc.add_paragraph(explanation)
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.add_run().add_picture(str(screens / f'{name}.png'), width=Inches(6.85 if name.startswith('firebase-') else 3.45))

output.parent.mkdir(parents=True, exist_ok=True)
doc.save(output)
print(f'Report created with {len(items)} actual screenshots: {output}')

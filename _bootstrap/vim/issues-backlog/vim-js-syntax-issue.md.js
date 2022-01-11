
class Helpers {
  printRecord(record) {
    // syntax highlighting issue - (closing) parenthesis inside 'template'(?) string
    // break syntax highlighting
    // Can use HLT! to trace syntax highloighting tree
    // console.log(`${record.name} (${record.id}`);
    console.log(`${record.name} ${record.id})`);
    // ISSUE: highlighting breaks afterwards
    // console.log(`${record.name} (${record.id}): ${record.paid ? "Paid" : "Not Paid"}`);
    // console.log(`${record.name} ${record.id}: ${record.paid ? "Paid" : "Not Paid"}`);
  }
  getStudentId(record) {
    return record.id;
  }
}

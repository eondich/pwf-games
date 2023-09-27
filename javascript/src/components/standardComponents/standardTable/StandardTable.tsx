import React from "react";
import "./StandardTable.scss";

export default function StandardTable ({rows, headers, keys}) {
  const headerRow = <tr>
    {
      headers.map(header => {
        let keyVal = header.toLowerCase().replace(" ", "");
        return <th key={`header-${keyVal}`}>{ header }</th>
      })
   }
  </tr>

  const tableBody = rows.map(row => {
    return <tr key={`row-${row.id}`}>
      {
        keys.map(key => {
          return <td key={`${key}-${row.id}`}>{ row[key] }</td>
        })
      }
    </tr>
  });

  return (
    <>
      <table className="standard-table">
        <thead>
          { headerRow }
        </thead>
        <tbody>
          { tableBody }
        </tbody>
      </table>
    </>
  );
}
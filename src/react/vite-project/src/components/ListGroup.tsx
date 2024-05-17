function ListGroup() {
  const items = [
    'Portalegre',
    'Ridijaneiro',
    'Sanpaul',
    'Beaga',
    'Pato Branco'
  ];
  
  return (<>
    <h1>List Group:</h1>   
    <ul className="list-group">
      {items.map(item => <li key={item}>{item}</li>)}
</ul>
</>
);
}

export default ListGroup;

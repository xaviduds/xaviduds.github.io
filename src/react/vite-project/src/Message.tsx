function Message() {
  const name = 'Duds';

  if (name)
    return <h1>Hello, {name}!</h1>;
  return <h1>Hello, World then i guess!</h1>;
}

export default Message;

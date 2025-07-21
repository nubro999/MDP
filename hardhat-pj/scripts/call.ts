

async function call() {
    const [owner, addr1, addr2] = await ethers.getSigners();


  const contractAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"; // 실제 배포된 주소
  const Hello = await ethers.getContractFactory("Hello");
  const hello = Hello.attach(contractAddress).connect(addr1); // 연결된 계약 인스턴스 생성

  // 함수 호출
  const greeting = await hello.greet();
  console.log("greeting:", greeting);
  console.log("call contract address:", hello.target);
  console.log("called by:", addr1.getAddress());
}

call();

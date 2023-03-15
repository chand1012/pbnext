import { Center, Title } from "@mantine/core";
import Head from "next/head";

export default function Home() {
  return (
    <>
      <Head>
        <title>Create PocketBase Next App</title>
        <meta name="description" content="By chand1012" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Center>
        <Title>PocketBase</Title>
      </Center>
    </>
  );
}

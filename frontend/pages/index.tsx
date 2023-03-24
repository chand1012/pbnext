import { Center, Title, Stack, Button } from "@mantine/core";
import PocketBase from "pocketbase";
import Head from "next/head";
import { useRouter } from "next/router";

export default function Home() {
  const router = useRouter();
  const pb = new PocketBase("http://127.0.0.1:8090");

  const email = pb.authStore.isValid ? pb.authStore.model?.email : "Guest";

  return (
    <>
      <Head>
        <title>Create PocketBase Next App</title>
        <meta name="description" content="By chand1012" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Center m="xl">
        <Stack spacing="xl">
          <Title align="center">PocketBase</Title>
          <Title order={3}>Welcome, {email}</Title>
          <Center>
            {email === "Guest" ? (
              <Button onClick={() => router.push("/login")}>Login</Button>
            ) : (
              <Button
                onClick={() => {
                  pb.authStore.clear();
                  router.push("/");
                }}
              >
                Logout
              </Button>
            )}
          </Center>
        </Stack>
      </Center>
    </>
  );
}

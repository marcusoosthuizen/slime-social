<script>
  import { prevent_default } from "svelte/internal";


	export let name;

	let username = "";
	let userinput

	function submit_username() {
		username = userinput;
	}
</script>

<main>
	<!-- Log in  -->
	{#if username == ""}
	<div id="welcome-container">
		<h1 id="welcome-text">Welcome to Slime Social!</h1>
		<img id="welcome-slime" src="/slime.gif" alt="">
	</div>
	
	<form id="username-form" on:submit|preventDefault>
		<h2>Select a Name </h2>
		<input id="username-input" placeholder="Enter Username" type="text" bind:value={userinput}>
		<img on:click={submit_username} src="/continue.png" id="username-button" alt="">
	</form>
	{/if}
	<!-- Log in -->

	<!-- Main -->
	{#if username != ""}
		<ul id="topbar">
			<h1>Slime Social</h1>
			<img style="" id="bar-slime" src="/slime.gif" alt="">
			<h2 class="bar-item">Changelog</h2>
			<h2 style="color: green" class="bar-item">{username}</h2>
		</ul>

		<div id="chatbox"></div>
	{/if}
	<!-- Main -->
</main>

<style>
	main {
		width: 100vw;
		height: 100vh;
		position: absolute;
		left: 0;
		top: 0;
		
		font-family: 'Silkscreen', cursive;
		background-color: #282a36;
		color: #f8f8f2;
		padding: 0px;
		margin: 0px;

		display: flex;
		flex-flow: column nowrap;
		align-items: center;
		justify-content: center;
	}

	#welcome-container {
		text-align: center;
		display: flex;
		flex-flow: row nowrap;
		align-items: center;

		
	}
	#welcome-text {
		text-align: center;
		font-size: 42px;
	}
	#welcome-slime {
		margin-left: 21px;
		width: 100px;
		height: 100px;
	}

	#username-form {
		margin-top: 84px;
		padding-bottom: 420px;
	}
	#username-input {
		width: 150px;
		height: 24px;
		border-radius: 0px;
		border: black solid 5px;
		font-family: 'Silkscreen', cursive;
	}
	#username-button {
		width: 32px;
		height: 32px;
		transform: translateY(13px);
		border: black solid 2px;
		image-rendering: pixelated;
		cursor: pointer;
	}

	#topbar {
		display: flex;
		flex-flow: row nowrap;
		position: absolute;
		left: 0;
		top: 0;
		width: 100vw;
		height: 100px;
		justify-content: flex-start;
		align-items: center;
		margin: 0px;
		padding: 0px;
	}
	#bar-slime {
		margin-right: auto;
		width: 80px;
		height: 80px;
	}

	.bar-item {
		margin-left: 21px;
		margin-right: 21px;

		cursor: pointer;
		-webkit-touch-callout: none;
		-webkit-user-select: none;
		-khtml-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
	}
	.bar-item:hover {
		text-decoration: underline;
	}

	#chatbox {
		background-image: url(/chatbox.png);
		background-repeat: no-repeat;
		background-size: 400px 640px;
		image-rendering: pixelated;
		width: 400px;
		height: 640px;
		transform: scale(1);
	}
	
</style>

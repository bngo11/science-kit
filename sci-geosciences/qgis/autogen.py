#!/usr/bin/env python3

import json

async def generate(hub, **pkginfo):
	github_user = "qgis"
	github_repo = pkginfo.get("name")
	json_data = await hub.pkgtools.fetch.get_page(f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True)
	version = None
	dl_url = "https://qgis.org/downloads"

	for item in json_data:
		try:
			if item["prerelease"] or item["draft"]:
				continue

			version = item["name"]
			list(map(int, version.split(".")))
			break

		except (KeyError, IndexError, ValueError):
			continue

	if version:
		url = f"{dl_url}/qgis-{version}.tar.bz2"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=url.rsplit("/")[-1])]
		)
		ebuild.push()

# vim: ts=4 sw=4 noet

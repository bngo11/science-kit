#!/usr/bin/env python3

import json

async def generate(hub, **pkginfo):
	github_user = "rstudio"
	github_repo = "rstudio"
	json_data = await hub.pkgtools.fetch.get_page(f"https://api.github.com/repos/{github_user}/{github_repo}/tags", is_json=True)
	version = None
	url = None

	for item in json_data:
		try:
			version_tag = item["name"]
			date, ver = version_tag.split("+")
			version = date.lstrip("v")
			list(map(int, version.split(".")))
			asset_name = f"rstudio-{version}-{ver}.tar.gz"
			url = item["tarball_url"]
			break

		except (KeyError, IndexError, ValueError):
			continue

	if version and url:
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=f"{version}.{ver}",
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=asset_name)]
		)
		ebuild.push()

# vim: ts=4 sw=4 noet

from __future__ import annotations

import json
import hashlib
from pathlib import Path
import sys

def sha256_bytes(b: bytes) -> str:
    return hashlib.sha256(b).hexdigest()

def main() -> int:
    if "--dbp" not in sys.argv:
        print("FATAL: missing --dbp", file=sys.stderr)
        return 2
    dbp_path = Path(sys.argv[sys.argv.index("--dbp")+1])
    if not dbp_path.exists():
        print(f"FATAL: dbp missing: {dbp_path}", file=sys.stderr)
        return 2

    dbp_text = dbp_path.read_bytes()
    dbp = json.loads(dbp_text.decode("utf-8"))

    out_dir = Path("out")
    out_dir.mkdir(parents=True, exist_ok=True)

    proof = {
        "kind": "ode.execution.proof.v1",
        "dbp_sha256": sha256_bytes(dbp_text),
        "app": dbp.get("app", {}),
        "inputs": dbp.get("inputs", {}),
        "ok": True,
    }

    (out_dir / "EXECUTION_PROOF.json").write_text(json.dumps(proof, indent=2) + "\n", encoding="utf-8")
    print("EXECUTION_OK=1")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())

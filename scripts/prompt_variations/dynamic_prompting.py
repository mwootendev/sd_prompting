from __future__ import annotations
import logging
from string import Template
from pathlib import Path
import argparse
import os
from itertools import chain

from wildcard.wildcardmanager import WildcardManager
from generator.randomprompt import RandomPromptGenerator

parser = argparse.ArgumentParser()
parser.add_argument("--wildcard_dir", type=str, help="Path to directory with wildcard files", default=os.path.join('./', 'wildcards'))
parser.add_argument("--prompt_file", type=str, help="Path to file containing the prompt templates")
parser.add_argument("--count", type=str, help="Number of variations to generate", default=10)
cmd_opts = parser.parse_args()

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

is_empty_line = lambda line: line is None or line.strip() == "" or line.strip().startswith("#")

WILDCARD_DIR = Path(getattr(cmd_opts, "wildcard_dir"))
PROMPT_FILE = Path(getattr(cmd_opts, "prompt_file"))
num_images = int(getattr(cmd_opts, "count"))

wildcard_manager = WildcardManager(WILDCARD_DIR)

def parse_line(line):
    prompt_generator = RandomPromptGenerator(wildcard_manager, line)
    return prompt_generator.generate(num_images)

all_prompts = []
with PROMPT_FILE.open(encoding="utf8", errors="ignore") as prompt_file:
    lines = [line.strip() for line in prompt_file if not is_empty_line(line)]
    for line in lines:
        all_prompts.append(parse_line(line))
        
flat_prompts = list(chain.from_iterable(all_prompts))

print(*flat_prompts, sep='\n')
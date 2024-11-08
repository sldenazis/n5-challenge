# Terraform files and modules

## Description

This directory contains the infraestructure definitions for the challenge.
In order to keep things simple, both modules and definitions are in this same repository.
I don't recommend this approach for a real project, I would rather use separated repositories for modules (using git tag/releases approach for versioning) and separated repositories for different infraestructure components.

## Usage

There is a github-actions automation in place, it will run terraform plan on Pull Requests (for peer review purposes) and apply on merge to main branch.

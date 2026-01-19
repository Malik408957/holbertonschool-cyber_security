# 0x0c Web Application Forensics – Task 0: Attacker Service

## Project Description

This task focuses on analyzing authentication logs to identify which service was used by attackers to gain access to the system. By examining log entries, we can extract useful information about authentication attempts and determine the targeted service.

## Objective

The goal of this task is to analyze the `auth.log` file and identify the service most frequently involved in authentication-related events linked to the attack.

## Files Used

- `auth.log`: Authentication log file containing login attempts and system authentication events.
- `0-service.sh`: Bash script used to analyze the log file.

## Script Description

The script extracts specific fields from the `auth.log` file, counts repeated entries, and sorts them to identify patterns in authentication activity.

The output shows that the most significant authentication events are related to:


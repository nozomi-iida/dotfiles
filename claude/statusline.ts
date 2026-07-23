#!/usr/bin/env bun
// Claude Code statusline
// stdin から渡される JSON を読んで、ディレクトリ /
// サブスクリプションの使用制限の使用量を表示する。
//
// rate_limits は Claude.ai サブスクリプション利用時、かつ最初の API 応答後にのみ入る。

// top-level await を使うためモジュール扱いにする
export {};

type RateLimitWindow = {
  used_percentage?: number;
  resets_at?: number;
};

type StatuslineInput = {
  cwd?: string;
  workspace?: { current_dir?: string };
  rate_limits?: Record<string, RateLimitWindow | undefined>;
};

const DIM = "\x1b[2m";
const RESET = "\x1b[0m";
const CYAN = "\x1b[36m";
const GREEN = "\x1b[32m";
const YELLOW = "\x1b[33m";
const RED = "\x1b[31m";

const DAY_MS = 86_400_000;

// 使用量に応じた色。少ない=緑 / 70%以上=黄 / 90%以上=赤
const colorFor = (pct: number): string =>
  pct >= 90 ? RED : pct >= 70 ? YELLOW : GREEN;

const pad = (n: number): string => String(n).padStart(2, "0");

// 24時間以内なら時刻だけ、それ以上先なら日付も付ける
const formatReset = (resetsAt: number): string => {
  const date = new Date(resetsAt * 1000);
  const time = `${pad(date.getHours())}:${pad(date.getMinutes())}`;
  if (date.getTime() - Date.now() < DAY_MS) return time;
  return `${pad(date.getMonth() + 1)}/${pad(date.getDate())} ${time}`;
};

// rate_limits の 1 ウィンドウを "ラベル XX%(リセット HH:MM)" に整形
const limitSegment = (
  window: RateLimitWindow | undefined,
  label: string,
): string | undefined => {
  if (window?.used_percentage == null) return undefined;

  const used = Math.round(window.used_percentage);
  const segment = `${DIM}${label} ${colorFor(used)}${used}%${RESET}`;

  if (window.resets_at == null) return segment;
  return `${segment}${DIM}(${formatReset(window.resets_at)})${RESET}`;
};

const input: StatuslineInput = await Bun.stdin.json();

const cwd = input.workspace?.current_dir ?? input.cwd;
const rateLimits = input.rate_limits;

const segments = [
  cwd ? `${CYAN}${cwd.split("/").filter(Boolean).pop() ?? cwd}${RESET}` : undefined,
  limitSegment(rateLimits?.five_hour, "5h"),
  limitSegment(rateLimits?.seven_day, "7d"),
].filter((segment) => segment !== undefined);

// " | " 区切りで出力
process.stdout.write(segments.join(`${DIM} | ${RESET}`));

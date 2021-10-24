output "self_link" {
  description = "The redis instance"
  value       = google_redis_instance.redis
}

output "id" {
  description = "The id of the redis instance"
  value       = google_redis_instance.redis.id
}

output "host" {
  description = "The hostname of the redis instance"
  value       = google_redis_instance.redis.host
}

output "port" {
  description = "The port of the redis instance"
  value       = google_redis_instance.redis.port
}

output "persistence_iam_identity" {
  description = "The cloud IAM identity used by the redis instance"
  value       = google_redis_instance.redis.persistence_iam_identity
}
